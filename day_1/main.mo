import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor Challenges {

    // challenge 1
    public query func add(_n: Nat, _m: Nat) : async Nat {
        return _n + _m;
    };

    // challenge 1
    public query func square(_n: Nat) : async Nat {
        return _n * _n;
    };

    // challenge 3
    public query func days_to_second(_n: Nat) : async Nat {
        return _n * 3600;
    };

    // challenge 4
    var counter: Nat = 0;

    public func increment_counter(_n: Nat) : async Nat {
        counter += _n;
        return counter;
    };


    public func clear_counter(_n: Nat) : async () {
        counter := 0;
    };

    // challenge 5
    public query func divide(_x: Nat, _y: Nat) : async Bool {
        return _divide(_x, _y);
    };

    // challenge 6
    public query func is_even(_x: Nat) : async Bool {
        return _divide(_x, 2);
    };

    // challenge 7
    public query func sum_of_array(_xr: [Nat]) : async Nat {
        var s = 0;
        for(i in _xr.vals()) { 
            s+= i;
        };

        return s;
    };

    // challenge 8
    public query func maximum(_xr: [Nat]) : async Nat {
        var s = 0;
        for(i in _xr.vals()) { 
            if (i > s) { s:= i;}
        };

        return s;
    };

    // challenge 9
    public query func remove_from_array(_xr: [Nat], _n: Nat) : async [Nat] {
        return Array.filter(_xr, func(val: Nat) : Bool { _n != val });
    };

    // challenge 10
    public query func selection_sort(_xr: [Nat]) : async [Nat] {
        var len: Nat = _xr.size() - 1;
        var result: [var Nat] = Array.thaw(_xr);

        for(j in Iter.range(0, len)){
            var i_min = j;

            for(i in Iter.range(j+1, len)){
                if(result[i] < result[i_min]) { i_min := i };
            };

            // swap
            if(i_min != j ){
                swap(result, i_min, j);
            };
        };

        return Array.freeze(result);
    };

    private func _divide(_x: Nat, _y: Nat) : Bool {
        return (_x % _y) == 0;
    };

    private func swap(arr: [var Nat], i: Nat, j: Nat) {
        var tmp = arr[i];
        arr[i] := arr[j];
        arr[j] := tmp;
    }
};