import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";


actor day_2 {

    public query func nat_to_nat8(n: Nat) : async ?Nat8 {
        if(n < 256) {
            return  ?Nat8.fromNat(n)
        };
        return null;
    };

    public query func max_number_with_n_bits(n: Nat) : async Nat {
        return Nat.pow(2, n);
    };

    public query func decimal_to_bits(n: Nat) : async Text {
        var x = n;
        var i: Nat8 = 0;
        var binary: Text = "";
        while(x > 0){
            binary := Nat.toText(x%2) # binary;
            x := x/2;
            i := i+1;
        };

        return binary;
    };
};