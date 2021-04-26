import Combine
import Foundation

struct AnyMessagingPublisher<Output, Failure> where Failure: Error {
    @usableFromInline internal let box: PublisherBoxBase<Output, Failure>

    @inlinable
    init<P>(_ publisher: P) where Output == P.Output, Failure == P.Failure, P: MessagingPublisher {
        self.box = PublisherBox(base: publisher)
    }

    func postMessage(text: String) {
        self.box.postMessage(text: text)
    }

    func postMessage(type: PostbackType, postbackData: PostbackData) {
        self.box.postMessage(type: type, postbackData: postbackData)
    }

    func load() {
        self.box.load()
    }
}

/// A type-erasing base class. Its concrete subclass is generic over the underlying
/// publisher.
@usableFromInline
class PublisherBoxBase<Output, Failure: Error>: Publisher {
    internal init() {}

    @inlinable
    internal func receive<SubscriberType: Subscriber>(subscriber: SubscriberType)
        where Failure == SubscriberType.Failure, Output == SubscriberType.Input
    {
        fatalError("required function to be overriden")
    }

    func postMessage(text: String) {
        fatalError("required function to be overriden")
    }

    func postMessage(type: PostbackType, postbackData: PostbackData) {
        fatalError("required function to be overriden")
    }

    func load() {
        fatalError("required function to be overriden")
    }
}

@usableFromInline
final class PublisherBox<PublisherType: MessagingPublisher>: PublisherBoxBase<PublisherType.Output, PublisherType.Failure> {
    @usableFromInline internal let base: PublisherType

    internal init(base: PublisherType) {
        self.base = base
        super.init()
    }

    @inlinable
    override internal func receive<SubscriberType: Subscriber>(subscriber: SubscriberType)
        where Failure == SubscriberType.Failure, Output == SubscriberType.Input
    {
        self.base.subscribe(subscriber)
    }

    override func postMessage(text: String) {
        self.base.postMessage(text: text)
    }

    override func postMessage(type: PostbackType, postbackData: PostbackData) {
        self.base.postMessage(type: type, postbackData: postbackData)
    }

    override func load() {
        self.base.load()
    }
}
