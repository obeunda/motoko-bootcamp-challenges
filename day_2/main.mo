import Array "mo:base/Array";
import Blob "mo:base/Blob";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Pattern "mo:base/Char";
import Text "mo:base/Text";
import Prim "mo:prim";


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

    public query func capitalize_character(c: Char) : async Char {
        return Prim.charToUpper(c);
    };

    public query func capitalize_text(text: Text) : async Text {
        return Text.map(text, Prim.charToUpper);
    };

    public query func is_inside(text: Text, c: Char) : async Bool {
        return Text.contains(text, #char c);
    };

    public query func trim_whitespace(text: Text) : async Text {
        return Text.trim(text, #char ' ');
    };

    public query func duplicated_character(text: Text) : async Text {

        var c : Char = ' ';

        for(it in text.chars()){
            if(it == c){
                return Char.toText(it);
            };
            c := it;
        };

        return text;
    };  

    public query func size_in_bytes(text: Text) : async Nat {
        var b: Blob = Text.encodeUtf8(text);
        let arr: [Nat8] = Blob.toArray(b);
        arr.size();
    };

    public query func bubble_sort(arr: [Nat]) : async [Nat] {
        
        let len : Nat = arr.size() - 1;
        let _xr : [var Nat] = Array.thaw(arr);
        for(i in Iter.range(1, len)){

            for(j in Iter.range(0, len-1)){
                let first: Nat = _xr[j];
                let second: Nat = _xr[j+1];

                if(first > second){
                    _xr[j] := second;
                    _xr[j+1] := first;
                };
            };
        };

        return Array.freeze(_xr);
    };
};