import XCTest
import LibP2P
import LibP2PNoise
import LibP2PMPLEX
import CID
import CryptoSwift
@testable import LibP2PKadDHT
import Multihash

class LibP2PKadDHTTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// ********************************************
    ///    Testing External KadDHT - Heartbeat
    /// ********************************************
    ///
    /// This test manually triggers one KadDHT heartbeat that kicks off a FindNode lookup for our libp2p PeerID
    /// A heartbeat / node lookup takes about 22 secs and discovers about 20 peers...
    /// 📒 --------------------------------- 📒
    /// Routing Table [<peer.ID PiV5bE>]
    /// Bucket Count: 1 buckets of size: 20
    /// Total Peers: 20
    /// b[0] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0]
    /// ---------------------------------------
    /// 2 heartbeats --> Time:  48 seconds,  Mem: 12.5 --> 13.8,  CPU: 0-12%,  Peers: 28
    /// 📒 --------------------------------- 📒
    /// Routing Table [<peer.ID PiV5bE>]
    /// Bucket Count: 2 buckets of size: 20
    /// Total Peers: 28
    /// b[0] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    /// b[1] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    /// ---------------------------------------
    /// 3 heartbeats --> Time:  59 seconds,  Mem: 12.5 --> 14.5,  CPU: 0-12%,  Peers: 27
    func testLibP2PKadDHT_SingleHeartbeat() throws {
        /// Init the libp2p node
        let lib = try makeHost()
        
        /// Prepare our expectations
        //let expectationNode1ReceivedNode2Subscription = expectation(description: "Node1 received fruit subscription from Node2")
        
        /// Start the node
        try lib.start()
                
        /// Do your test stuff ...
        XCTAssertTrue(lib.dht.kadDHT.state == .started)
        
        //let exp = expectation(description: "Wait for response")
        print("*** Before Lookup ***")
        print(lib.dht.kadDHT.peerstore)
        print("")
        
        print("*** Before Lookup ***")
        lib.peers.dumpAll()
        print("")
        
        try (0..<1).forEach { _ in
            /// Trigger a heartbeat (which will perform a peer lookup for our peerID)
            try lib.dht.kadDHT.heartbeat().wait()

            sleep(2)
        }
      
        print("*** After Lookup ***")
        print("(DHT Peerstore: \(lib.dht.kadDHT.peerstore.count)) - \(lib.dht.kadDHT.peerstore)")
        print("")
       
        print("*** After Lookup ***")
        let pAll = try lib.peers.all().wait()
        print("(Libp2p Peerstore: \(pAll.count)) - \(pAll.map { "\($0.id)\nMultiaddr: [\($0.addresses.map { $0.description }.joined(separator: ", "))]\nProtocols: [\($0.protocols.map { $0.stringValue }.joined(separator: ", "))]\nMetadata: \($0.metadata.map { "\($0.key): \(String(data: Data($0.value), encoding: .utf8) ?? "NIL")" }.joined(separator: ", "))" }.joined(separator: "\n\n"))")
      
        print("")
        lib.peers.dumpAll()
        print("")
        
        print("Connections: ")
        print(try lib.connections.getConnections(on: nil).wait())
        
        print("*** Metrics ***")
        lib.dht.kadDHT.metrics.history.forEach { print($0.event) }
        
        print("*** Routing Table ***")
        print(lib.dht.kadDHT.routingTable)
        
        //waitForExpectations(timeout: 10, handler: nil)
        sleep(2)
        
        /// Stop the node
        lib.shutdown()
        
        print("All Done!")
    }
  
    
    /// ******************************************************
    ///    Testing External KadDHT - Single Query - GetValue
    /// ******************************************************
    ///
    /// - For getValue(key: )
    ///   - let key = try "/pk/".bytes + CID("QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ").multihash.value
    func testLibP2PKadDHT_DirectPing() throws {
        /// Init the libp2p node
        let lib = try makeHost()

        /// Start the node
        try lib.start()
              
        /// Do your test stuff ...
        XCTAssertTrue(lib.dht.kadDHT.state == .started)

        let bootstrapPeer = PeerInfo(
            peer: try PeerID(cid: "QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ"),
            addresses: [
                try Multiaddr("/ip4/104.131.131.82/tcp/4001/p2p/QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ")
            ]
        )
        
        let response = try lib.dht.kadDHT._sendQuery(.ping, to: bootstrapPeer).wait()
        print(response)

        sleep(2)

        /// Stop the node
        lib.shutdown()

        print("All Done!")
    }
    
    /// ******************************************************
    ///    Testing External KadDHT - Single Query - GetValue
    /// ******************************************************
    ///
    /// - For getValue(key: )
    ///   - let key = try "/pk/".bytes + CID("QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ").multihash.value
    func testLibP2PKadDHT_GetValueQuery() throws {
        /// Init the libp2p node
        let lib = try makeHost()
        
        /// Start the node
        try lib.start()
                
        /// Do your test stuff ...
        XCTAssertTrue(lib.dht.kadDHT.state == .started)
      
        let peerID = "QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ"
        //let peerID = "QmNnooDu7bfjPFoTZYxMNLWUQJyrVwtbZg5gBMjTezGAJN"
        
        let key = try "/pk/".bytes + CID(peerID).multihash.value
        
        let val = try lib.dht.kadDHT.getUsingLookupList(key).wait()
        print(val)
      
        XCTAssertNotNil(val)
        if let val = val {
            XCTAssertEqual(try PeerID(marshaledPublicKey: val.value).b58String, peerID)
        }
        
        sleep(2)
        
        /// Stop the node
        lib.shutdown()
        
        print("All Done!")
    }
  
    func testPeerRecord() throws {
        let recordData = Data(hex: "080012a60430820222300d06092a864886f70d01010105000382020f003082020a0282020100a1f5c0e7c0d5e556afc0e84566f8c565773adb548ddc219ca9688613a0096c2dfd069804c84968545b9c9df19dd131cc8408b7781df7ddfaf208a42a821523ce03955164a62dcab6bd10dd26f8507517567ca128f00a056d8636b9549ddb59ca727628775c90bd91d6251adbdfd36bf68a09c3bfe69e1b1587e8f31a4b55afc8095e7b6f6683165f9c0ef0ad1b22d8b73749ee02aa46566cd5f7a9ff6eb1099fe36b363abd4e1293108a6d473a349e77aca15e49b20ffe61b4222eb3a634e8481d71a7fdceea88a2044fa5cedde1dee314e27880bc713ca578814684e85e0d21cff40e23c341f13ee1a06452f284664999862973e51d692b578cd9b7de89d786ad6baebcf8dfc343db8eda434a15929591917c52bf16741359149d0e7092bc919928f1d5b25cb48b0f90a7a05b0eb29adca993f893c6fb137a53a5c470a8a309b574bb4fd80879bde7dcc237eaf2ce9a17b9193032df99c8bf551987561ee264a09730f9029610571625e0d0e1e2a7f90469a6a480ed08cf9b4c3af0567bfe9abf470079d8cc7d7f22efc83598f86c9e0678caf79e2299a99c47c8d057e7f3b8af40185c8dd499a1c167c358d7ab83af6581944ce0b8b6bd2cfe4bf80c8c9e7f61fe94816df79e12ae5e82c588f894b86fd599da5912f8754de2a23f2d1529845a5570a72d8d8537325b95dd3c69d9ca30b8186c20170d10955b7da216822c730203010001")

        let pub = try PeerID(marshaledPublicKey: recordData)
        print(pub)
        print(pub.b58String)
        print(pub.cidString)
    }
  
    /// **********************************************************
    ///    Testing Internal KadDHT - Single Query - FindProvider
    /// **********************************************************
    ///
    /// - For findProvider(cid: )
    ///   - let key = try CID("QmXuNFLZc6Nb5akB4sZsxK3doShsFKT1sZFvxLXJvZQwAW").multihash.value (results in found providers)
    func testLibP2PKadDHT_FindProviderQuery() throws {
        /// Init the libp2p node
        let lib = try makeHost()
        
        /// Prepare our expectations
        //let expectationNode1ReceivedNode2Subscription = expectation(description: "Node1 received fruit subscription from Node2")
        
        /// Start the node
        try lib.start()
                
        /// Do your test stuff ...
        XCTAssertTrue(lib.dht.kadDHT.state == .started)
        
        /// Attempt to find providers of the following CID
        //let key = try CID("QmXuNFLZc6Nb5akB4sZsxK3doShsFKT1sZFvxLXJvZQwAW").multihash.value
        let key = try CID("QmdSn5nS2toXqj5jKGvpsoNJjk2rofY6ctk7RY86t6KeMS").multihash.value
        let val = try lib.dht.kadDHT.getProvidersUsingLookupList(key).wait()
        print(val)
        XCTAssertFalse(val.isEmpty)
        
        sleep(2)
        
        /// Stop the node
        lib.shutdown()
        
        print("All Done!")
    }
    
    /// **************************************************************
    ///    Testing External KadDHT - Single Heartbeat - w/ Topology
    /// **************************************************************
    ///
    func testLibP2PKadDHT_SingleHeartbeat_Topology() throws {
        /// Init the libp2p node
        let lib = try makeHost()
        
        /// Start the node
        try lib.start()
                
        /// Do your test stuff ...
        XCTAssertTrue(lib.dht.kadDHT.state == .started)
        
        lib.topology.register(TopologyRegistration(protocol: "/meshsub/1.0.0", handler: TopologyHandler(onConnect: { peerID, conn in
            print("⭐️ Found a /meshsub/1.0.0 \(peerID)")
        })))
        
        //let exp = expectation(description: "Wait for response")
        print("*** Before Lookup ***")
        print(lib.dht.kadDHT.peerstore)
        print("")
        
        print("*** Before Lookup ***")
        lib.peers.dumpAll()
        print("")
        
        try (0..<1).forEach { _ in
            /// Trigger a heartbeat (which will perform a peer lookup for our peerID)
            try lib.dht.kadDHT.heartbeat().wait()

            sleep(2)
        }
                
        print("*** After Lookup ***")
        print("(DHT Peerstore: \(lib.dht.kadDHT.peerstore.count)) - \(lib.dht.kadDHT.peerstore)")
        print("")
       
        print("*** After Lookup ***")
        let pAll = try lib.peers.all().wait()
        print("(Libp2p Peerstore: \(pAll.count)) - \(pAll.map { "\($0.id)\nMultiaddr: [\($0.addresses.map { $0.description }.joined(separator: ", "))]\nProtocols: [\($0.protocols.map { $0.stringValue }.joined(separator: ", "))]\nMetadata: \($0.metadata.map { "\($0.key): \(String(data: Data($0.value), encoding: .utf8) ?? "NIL")" }.joined(separator: ", "))" }.joined(separator: "\n\n"))")
        
        print("")
        lib.peers.dumpAll()
        print("")
        
        print("Connections: ")
        print(try lib.connections.getConnections(on: nil).wait())
        
        print("*** Metrics ***")
        lib.dht.kadDHT.metrics.history.forEach { print($0.event) }
        
        print("*** Routing Table ***")
        print(lib.dht.kadDHT.routingTable)
        
        //waitForExpectations(timeout: 10, handler: nil)
        sleep(2)
        
        /// Stop the node
        lib.shutdown()
        
        print("All Done!")
    }
    
    var nextPort:Int = 10000
    private func makeHost() throws -> Application {
        let lib = try Application(.testing, peerID: PeerID(.Ed25519))
        lib.security.use(.noise)
        lib.muxers.use(.mplex)
        lib.dht.use(.kadDHT(mode: .client, options: .default, autoUpdate: false))
        lib.servers.use(.tcp(host: "127.0.0.1", port: nextPort))
        
        nextPort += 1
        
        lib.logger.logLevel = .warning
        
        return lib
    }

}
