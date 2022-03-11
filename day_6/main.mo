import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Text "mo:base/Text";
import Option "mo:base/Option";
import HTTP "http";

actor {

    // challenge 1
    type TokenIndex = Nat;
    type Error = {
        #NotFound;
        #ToLate;
    };

    // challenge 2
    var registry: HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash);

    // challenge 3 
    stable var index: TokenIndex = 0;
    type Result<T,E> = Result.Result<T, E>;
    public shared({caller}) func mint(): async Result<(), Text>{

        if(Principal.isAnonymous(caller)){
            return #err("Anonymous is not allow to mint")
        };
        registry.put(index, caller);
        index += 1;

        #ok();
    };

    // challenge 4
    public shared({caller}) func transfert(to: Principal, index: TokenIndex): async Result<(), Text>{

        if(Principal.isAnonymous(caller)){
            return #err("Anonymous is not allow to mint")
        };

        registry.put(index, caller);
        #ok();
    };

    // challenge 5
    type Iter<K, V> = Iter.Iter<(K, V)>;
    public shared({caller}) func balance(): async [TokenIndex]{
        var result: List.List<TokenIndex> = List.nil();

        for((index,aPrincipal) in registry.entries()){
            if(Principal.equal(caller, aPrincipal)) result := List.push(index, result);
        };

        List.toArray(result);
    };


    //challenge 6, 7

    stable var entries: [(TokenIndex, Principal)] = [];

    public query func http_request(request : HTTP.Request) : async HTTP.Response {

        let last_principal =  switch(registry.get(index)) { 
            case(?p) Principal.toText(p);
            case(null) "";
        }; 

        let response = {
            body = Text.encodeUtf8("{\"token_count\" : \"" # Nat.toText(registry.size()) # "\", \"last_principal\" : \"" # last_principal # " }");
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            streaming_strategy = null
        };
        return(response)
    };


    system func preupgrade() {
        entries := Iter.toArray(registry.entries());
    };

    system func postupgrade() {
        registry := HashMap.fromIter<TokenIndex, Principal>(entries.vals(), entries.size(), Nat.equal, Hash.hash);
    };

    // Challenge 8 see wallet.mo
}