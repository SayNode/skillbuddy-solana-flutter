import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';

import '../../util/constants.dart';

enum SolanaNetwork {
  testnet,
  mainnet,
}

class SolanaService extends GetxService {
  late SolanaClient solanaClient;
  Rx<SolanaNetwork> network = SolanaNetwork.mainnet.obs;

  RxString connectedAccountLabel = ''.obs;
  RxString authToken = ''.obs;
  Rx<Uint8List> publicKey = Uint8List(0).obs;
  final RxnString walletAddress = RxnString();
  final RxnString walletBalance = RxnString();

  @override
  void onInit() {
    _setupSolanaClient();
    super.onInit();
  }

  void _setupSolanaClient({bool isMainnet = true}) {
    solanaClient = SolanaClient(
      rpcUrl: Uri.parse(
        isMainnet
            ? SkillBuddyConstants.mainnetRpcUrl
            : SkillBuddyConstants.testnetRpcUrl,
      ),
      websocketUrl: Uri.parse(
        isMainnet
            ? SkillBuddyConstants.mainnetWsUrl
            : SkillBuddyConstants.testnetWsUrl,
      ),
    );

    walletAddress.bindStream(
      publicKey.stream
          .map((Uint8List bytes) => Ed25519HDPublicKey(bytes).toBase58()),
    );
    walletBalance.bindStream(
      publicKey.stream
          .asyncMap((_) => getBalanceSOL())
          .map((double bal) => bal.toStringAsFixed(4)),
    );
  }

  Future<void> authorizeWallet() async {
    final LocalAssociationScenario session =
        await LocalAssociationScenario.create();
    session.startActivityForResult(null).ignore();

    final MobileWalletAdapterClient client = await session.start();
    final AuthorizationResult? result = await client.authorize(
      identityUri: Uri.parse('https://www.skillbuddy.io'),
      iconUri: Uri.parse('favicon.ico'),
      identityName: 'Solana',
      cluster: network.value == SolanaNetwork.mainnet
          ? SkillBuddyConstants.mainnetCluster
          : SkillBuddyConstants.testnetCluster,
    );

    if (result != null) {
      authToken.value = result.authToken;
      publicKey.value = result.publicKey;
      connectedAccountLabel.value = result.accountLabel ?? 'Unknown'.tr;
    }
    await session.close();
  }

  Future<void> deauthorizeWallet() async {
    if (authToken.value.isEmpty) {
      return;
    }
    final LocalAssociationScenario session =
        await LocalAssociationScenario.create();
    session.startActivityForResult(null).ignore();

    final MobileWalletAdapterClient client = await session.start();
    await client.deauthorize(authToken: authToken.value);
    authToken.value = '';
    publicKey.value = Uint8List(0);
    connectedAccountLabel.value = '';
    walletAddress.value = null;
    walletBalance.value = null;
    await session.close();
  }

  Future<void> requestAirdrop() async {
    if (publicKey.value.isEmpty) return;
    await solanaClient.requestAirdrop(
      address: Ed25519HDPublicKey(publicKey.value),
      lamports: 1000000000, // 1 SOL = 1,000,000,000 lamports
    );
  }

  Future<double> getBalanceSOL({
    Commitment commitment = Commitment.confirmed,
  }) async {
    if (publicKey.value.isEmpty) return 0.0;
    final String base58 = Ed25519HDPublicKey(publicKey.value).toBase58();
    final BalanceResult balanceResult = await solanaClient.rpcClient.getBalance(
      base58,
      commitment: commitment,
    );

    return balanceResult.value / lamportsPerSol;
  }
}
