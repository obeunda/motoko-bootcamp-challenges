import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";


actor day_5 {

    //Challenge 1
    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");
    public shared({caller}) func is_anonymous(): async Bool {
        return Principal.equal(caller, anonymous_principal);
    };

    //Challenge 2
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    
    //Challenge 3
    public shared({caller}) func add_favorite_number(n: Nat): async () {
        favoriteNumber.put(caller, n);
    };

    public shared({caller}) func show_favorite_number(): async ?Nat {
        favoriteNumber.get(caller);
    };   

    //Challenge 4
    public shared({caller}) func add_favorite_number_if_not_exist(n: Nat): async Text {
        let number: ?Nat = favoriteNumber.get(caller);

        switch(number){
            case(null){
                favoriteNumber.put(caller, n);
                "You've successfully registered your number";
            }; 
            case(?number){
                "You've already registered your number";
            };
        };
    };

    //Challenge 5
    public shared({caller}) func update_favorite_number(n: Nat): async () {
       favoriteNumber.put(caller, n);
    };

    public shared({caller}) func delete_favorite_number(): async () {
       favoriteNumber.delete(caller);
    };

    //Challenge 6
    public func deposit_cycles(): async Nat {
        let deposit: Nat = Cycles.available();
        let received = Cycles.accept(deposit);
        return deposit;
    }; 

    //Challenge 7 see ledger.mo

    // challenge 8
    stable var counter: Nat = 0;
    stable var version_number: Nat = 0;

    public func increment_counter(_n: Nat) : async Nat {
        counter += _n;
        return counter;
    };

    public func clear_counter(_n: Nat) : async () {
        counter := 0;
    };

    system func postupgrade() {
        version_number += 1;
    };

    public query func get_version_number(): async Nat {
        return version_number;
    };

    // Challenge 10 see upgrade.mo
}