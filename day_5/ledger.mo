import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";
import Caller "canister:day_5";


actor ledger {

    public shared({caller}) func withdraw_cycles(n: Nat): async Nat {
        Cycles.add(n);
        await Caller.deposit_cycles();
    }; 

}