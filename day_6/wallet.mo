import Result "mo:base/Result";

actor {

    type Result<T,E> = Result.Result<T, E>;

    let minter : actor {
        mint : () -> async Result<(), Text>;
    } = actor("rdmx6-jaaaa-aaaaa-aaadq-cai");

    public func mint(): async Result<(),Text> {
         return(await minter.mint())
    };
}