// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: DHT.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

/// can't use, because protocol-buffers doesn't support imports
/// so we have to duplicate for now :(
/// import "record.proto";

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

enum DHT {

    struct Record {
      // SwiftProtobuf.Message conformance is added in an extension below. See the
      // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
      // methods supported on all messages.

      /// adjusted for javascript
      var key: Data {
        get {return _key ?? Data()}
        set {_key = newValue}
      }
      /// Returns true if `key` has been explicitly set.
      var hasKey: Bool {return self._key != nil}
      /// Clears the value of `key`. Subsequent reads from it will return its default value.
      mutating func clearKey() {self._key = nil}

      var value: Data {
        get {return _value ?? Data()}
        set {_value = newValue}
      }
      /// Returns true if `value` has been explicitly set.
      var hasValue: Bool {return self._value != nil}
      /// Clears the value of `value`. Subsequent reads from it will return its default value.
      mutating func clearValue() {self._value = nil}

      var author: Data {
        get {return _author ?? Data()}
        set {_author = newValue}
      }
      /// Returns true if `author` has been explicitly set.
      var hasAuthor: Bool {return self._author != nil}
      /// Clears the value of `author`. Subsequent reads from it will return its default value.
      mutating func clearAuthor() {self._author = nil}

      var signature: Data {
        get {return _signature ?? Data()}
        set {_signature = newValue}
      }
      /// Returns true if `signature` has been explicitly set.
      var hasSignature: Bool {return self._signature != nil}
      /// Clears the value of `signature`. Subsequent reads from it will return its default value.
      mutating func clearSignature() {self._signature = nil}

      var timeReceived: String {
        get {return _timeReceived ?? String()}
        set {_timeReceived = newValue}
      }
      /// Returns true if `timeReceived` has been explicitly set.
      var hasTimeReceived: Bool {return self._timeReceived != nil}
      /// Clears the value of `timeReceived`. Subsequent reads from it will return its default value.
      mutating func clearTimeReceived() {self._timeReceived = nil}

      var unknownFields = SwiftProtobuf.UnknownStorage()

      init() {}

      fileprivate var _key: Data? = nil
      fileprivate var _value: Data? = nil
      fileprivate var _author: Data? = nil
      fileprivate var _signature: Data? = nil
      fileprivate var _timeReceived: String? = nil
    }

    struct Message {
      // SwiftProtobuf.Message conformance is added in an extension below. See the
      // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
      // methods supported on all messages.

      /// defines what type of message it is.
      var type: Message.MessageType {
        get {return _type ?? .putValue}
        set {_type = newValue}
      }
      /// Returns true if `type` has been explicitly set.
      var hasType: Bool {return self._type != nil}
      /// Clears the value of `type`. Subsequent reads from it will return its default value.
      mutating func clearType() {self._type = nil}

      /// defines what coral cluster level this query/response belongs to.
      /// in case we want to implement coral's cluster rings in the future.
      var clusterLevelRaw: Int32 {
        get {return _clusterLevelRaw ?? 0}
        set {_clusterLevelRaw = newValue}
      }
      /// Returns true if `clusterLevelRaw` has been explicitly set.
      var hasClusterLevelRaw: Bool {return self._clusterLevelRaw != nil}
      /// Clears the value of `clusterLevelRaw`. Subsequent reads from it will return its default value.
      mutating func clearClusterLevelRaw() {self._clusterLevelRaw = nil}

      /// Used to specify the key associated with this message.
      /// PUT_VALUE, GET_VALUE, ADD_PROVIDER, GET_PROVIDERS
      /// adjusted for javascript
      var key: Data {
        get {return _key ?? Data()}
        set {_key = newValue}
      }
      /// Returns true if `key` has been explicitly set.
      var hasKey: Bool {return self._key != nil}
      /// Clears the value of `key`. Subsequent reads from it will return its default value.
      mutating func clearKey() {self._key = nil}

      /// Used to return a value
      /// PUT_VALUE, GET_VALUE
      /// adjusted Record to bytes for js
      var record: Data {
        get {return _record ?? Data()}
        set {_record = newValue}
      }
      /// Returns true if `record` has been explicitly set.
      var hasRecord: Bool {return self._record != nil}
      /// Clears the value of `record`. Subsequent reads from it will return its default value.
      mutating func clearRecord() {self._record = nil}

      /// Used to return peers closer to a key in a query
      /// GET_VALUE, GET_PROVIDERS, FIND_NODE
      var closerPeers: [Message.Peer] = []

      /// Used to return Providers
      /// GET_VALUE, ADD_PROVIDER, GET_PROVIDERS
      var providerPeers: [Message.Peer] = []

      var unknownFields = SwiftProtobuf.UnknownStorage()

      enum MessageType: SwiftProtobuf.Enum {
        typealias RawValue = Int
        case putValue // = 0
        case getValue // = 1
        case addProvider // = 2
        case getProviders // = 3
        case findNode // = 4
        case ping // = 5
        case UNRECOGNIZED(Int)

        init() {
          self = .putValue
        }

        init?(rawValue: Int) {
          switch rawValue {
          case 0: self = .putValue
          case 1: self = .getValue
          case 2: self = .addProvider
          case 3: self = .getProviders
          case 4: self = .findNode
          case 5: self = .ping
          default: self = .UNRECOGNIZED(rawValue)
          }
        }

        var rawValue: Int {
          switch self {
          case .putValue: return 0
          case .getValue: return 1
          case .addProvider: return 2
          case .getProviders: return 3
          case .findNode: return 4
          case .ping: return 5
          case .UNRECOGNIZED(let i): return i
          }
        }

      }

      enum ConnectionType: SwiftProtobuf.Enum {
        typealias RawValue = Int

        /// sender does not have a connection to peer, and no extra information (default)
        case notConnected // = 0

        /// sender has a live connection to peer
        case connected // = 1

        /// sender recently connected to peer
        case canConnect // = 2

        /// sender recently tried to connect to peer repeatedly but failed to connect
        /// ("try" here is loose, but this should signal "made strong effort, failed")
        case cannotConnect // = 3
        case UNRECOGNIZED(Int)

        init() {
          self = .notConnected
        }

        init?(rawValue: Int) {
          switch rawValue {
          case 0: self = .notConnected
          case 1: self = .connected
          case 2: self = .canConnect
          case 3: self = .cannotConnect
          default: self = .UNRECOGNIZED(rawValue)
          }
        }

        var rawValue: Int {
          switch self {
          case .notConnected: return 0
          case .connected: return 1
          case .canConnect: return 2
          case .cannotConnect: return 3
          case .UNRECOGNIZED(let i): return i
          }
        }

      }

      struct Peer {
        // SwiftProtobuf.Message conformance is added in an extension below. See the
        // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
        // methods supported on all messages.

        /// ID of a given peer.
        var id: Data {
          get {return _id ?? Data()}
          set {_id = newValue}
        }
        /// Returns true if `id` has been explicitly set.
        var hasID: Bool {return self._id != nil}
        /// Clears the value of `id`. Subsequent reads from it will return its default value.
        mutating func clearID() {self._id = nil}

        /// multiaddrs for a given peer
        var addrs: [Data] = []

        /// used to signal the sender's connection capabilities to the peer
        var connection: Message.ConnectionType {
          get {return _connection ?? .notConnected}
          set {_connection = newValue}
        }
        /// Returns true if `connection` has been explicitly set.
        var hasConnection: Bool {return self._connection != nil}
        /// Clears the value of `connection`. Subsequent reads from it will return its default value.
        mutating func clearConnection() {self._connection = nil}

        var unknownFields = SwiftProtobuf.UnknownStorage()

        init() {}

        fileprivate var _id: Data? = nil
        fileprivate var _connection: Message.ConnectionType? = nil
      }

      init() {}

      fileprivate var _type: Message.MessageType? = nil
      fileprivate var _clusterLevelRaw: Int32? = nil
      fileprivate var _key: Data? = nil
      fileprivate var _record: Data? = nil
    }

}
#if swift(>=4.2)

extension DHT.Message.MessageType: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [DHT.Message.MessageType] = [
    .putValue,
    .getValue,
    .addProvider,
    .getProviders,
    .findNode,
    .ping,
  ]
}

extension DHT.Message.ConnectionType: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [DHT.Message.ConnectionType] = [
    .notConnected,
    .connected,
    .canConnect,
    .cannotConnect,
  ]
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension DHT.Record: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Record"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "key"),
    2: .same(proto: "value"),
    3: .same(proto: "author"),
    4: .same(proto: "signature"),
    5: .same(proto: "timeReceived"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self._key) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self._value) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self._author) }()
      case 4: try { try decoder.decodeSingularBytesField(value: &self._signature) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self._timeReceived) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._key {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._value {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._author {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._signature {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._timeReceived {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: DHT.Record, rhs: DHT.Record) -> Bool {
    if lhs._key != rhs._key {return false}
    if lhs._value != rhs._value {return false}
    if lhs._author != rhs._author {return false}
    if lhs._signature != rhs._signature {return false}
    if lhs._timeReceived != rhs._timeReceived {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension DHT.Message: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Message"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    10: .same(proto: "clusterLevelRaw"),
    2: .same(proto: "key"),
    3: .same(proto: "record"),
    8: .same(proto: "closerPeers"),
    9: .same(proto: "providerPeers"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self._type) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self._key) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self._record) }()
      case 8: try { try decoder.decodeRepeatedMessageField(value: &self.closerPeers) }()
      case 9: try { try decoder.decodeRepeatedMessageField(value: &self.providerPeers) }()
      case 10: try { try decoder.decodeSingularInt32Field(value: &self._clusterLevelRaw) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._type {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._key {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._record {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 3)
    } }()
    if !self.closerPeers.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.closerPeers, fieldNumber: 8)
    }
    if !self.providerPeers.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.providerPeers, fieldNumber: 9)
    }
    try { if let v = self._clusterLevelRaw {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 10)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: DHT.Message, rhs: DHT.Message) -> Bool {
    if lhs._type != rhs._type {return false}
    if lhs._clusterLevelRaw != rhs._clusterLevelRaw {return false}
    if lhs._key != rhs._key {return false}
    if lhs._record != rhs._record {return false}
    if lhs.closerPeers != rhs.closerPeers {return false}
    if lhs.providerPeers != rhs.providerPeers {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension DHT.Message.MessageType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "PUT_VALUE"),
    1: .same(proto: "GET_VALUE"),
    2: .same(proto: "ADD_PROVIDER"),
    3: .same(proto: "GET_PROVIDERS"),
    4: .same(proto: "FIND_NODE"),
    5: .same(proto: "PING"),
  ]
}

extension DHT.Message.ConnectionType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NOT_CONNECTED"),
    1: .same(proto: "CONNECTED"),
    2: .same(proto: "CAN_CONNECT"),
    3: .same(proto: "CANNOT_CONNECT"),
  ]
}

extension DHT.Message.Peer: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = DHT.Message.protoMessageName + ".Peer"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "addrs"),
    3: .same(proto: "connection"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self._id) }()
      case 2: try { try decoder.decodeRepeatedBytesField(value: &self.addrs) }()
      case 3: try { try decoder.decodeSingularEnumField(value: &self._connection) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._id {
      try visitor.visitSingularBytesField(value: v, fieldNumber: 1)
    } }()
    if !self.addrs.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.addrs, fieldNumber: 2)
    }
    try { if let v = self._connection {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: DHT.Message.Peer, rhs: DHT.Message.Peer) -> Bool {
    if lhs._id != rhs._id {return false}
    if lhs.addrs != rhs.addrs {return false}
    if lhs._connection != rhs._connection {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}