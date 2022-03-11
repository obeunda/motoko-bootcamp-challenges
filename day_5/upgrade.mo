import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

// Challenge 9
actor upgrade {

    stable var cache: [(Principal, Nat)] = [];

    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    

    public shared({caller}) func add_favorite_number(n: Nat): async Text {
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

    public shared({caller}) func update_favorite_number(n: Nat): async () {
       favoriteNumber.put(caller, n);
    };

    public shared({caller}) func delete_favorite_number(): async () {
       favoriteNumber.delete(caller);
    };

    public shared({caller}) func show_favorite_number(): async ?Nat {
        favoriteNumber.get(caller);
    };  

     system func preupgrade() {
    // Do something before upgrade
        cache := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        // Do something after upgrade
        favoriteNumber := HashMap.fromIter<Principal, Nat>(cache.vals(), cache.size(), Principal.equal, Principal.hash);
    }; 

}