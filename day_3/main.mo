import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Option "mo:base/Option";

actor day_3 {

    private func swap(arr: [var Nat], i: Nat, j: Nat) : [var Nat] {
        let i_value: Nat = arr[i];
        let j_value: Nat = arr[j];

        arr[i] := j_value;
        arr[j] := i_value;
        return arr;
    };

    public query func init_count(n: Nat) : async [Nat] {
        let arr: [var Nat] = Array.init(n, 0);
        for(i in Iter.range(0, n - 1)){
            arr[i] := i;
        };
        return Array.freeze(arr);
    };

    public query func seven(arr: [Nat]) : async Text {
        for(n in arr.vals()){
            if (n == 7){
                return "Seven is found";
            }
        };
        return "Seven not found";
    };

    public query func nat_opt_to_nat (n: ?Nat, m: Nat) : async Text {
        switch(n){
            case (null) {
               return Nat.toText(m); 
            };
            case (?something){
                return Nat.toText(something); 
            };              
        };
    };  

    public query func day_of_the_week  (n: Nat) : async ?Text {
        switch(n){
            case (1) {
               return ?"Monday"; 
            };
            case (2) {
               return ?"Tuesday"; 
            };
            case (3) {
               return ?"Wednesday"; 
            };
            case (4) {
               return ?"Thursday"; 
            };
            case (5) {
               return ?"Friday"; 
            };
            case (6) {
               return ?"Saturday"; 
            };
            case (7) {
               return ?"Sunday"; 
            };
            case (_){
                return null; 
            };              
        };
    };  

    public query func populate_array(xr: [?Nat]): async [Nat] {

        return Array.tabulate<Nat>(xr.size(), func(n: Nat){
            switch(xr[n]){
                case (null) {
                    return 0; 
                };
                case (?something){
                    return something; 
                };              
            };
        });
    };

    public query func sum_of_array(xr: [Nat]): async Nat {
        return Array.foldRight<Nat, Nat>(xr, 0, func(a: Nat, b: Nat){ a + b});
    };

    public query func square_of_array(xr: [Nat]): async [Nat] {
        return Array.map<Nat, Nat>(xr, func(a: Nat){ a * a});
    };

    public query func increase_by_index(xr: [Nat]): async [Nat] {
        return Array.mapEntries<Nat, Nat>(xr, func(a: Nat, b: Nat){ a + b});
    };

    public query func contains(xr: [Nat], n: Nat): async Bool {
        return _contains<Nat>(xr, n,  func(i: Nat, j: Nat) {i == j});
    };

    private func _contains<A>(xr: [A], a: A, f: (A, A) -> Bool): Bool {
        return Option.isSome(Array.find<A>(xr, func(it: A){ f(it,a)})) ;
    };

}