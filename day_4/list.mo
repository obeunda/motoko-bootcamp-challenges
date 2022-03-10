module {

    public type List<T> = ?(T, List<T>);

    public func is_null<T>(list: List<T>): Bool {
        switch(list){
            case(null) return true;
            case(?list) return false;
        };
    };

    public func last<T>(list: List<T>): ?T {
        switch(list){
            case(null) return null;
            case(?list){
                let (t,l) = list;
                if(is_null(l)){
                    return ?t;
                } else{
                    last(l);
                };
            };
        };
    };

    public func size<T>(list: List<T>): Nat {
        switch(list){
            case(null) return 0;
            case(?list){
                let (_,l) = list;
                return size(l) + 1;
            };
        };       
    };

    public func get<T>(list: List<T>, n: Nat): ?T {
        switch(list){
            case(null) return null;
            case(?list){
                let (t,l) = list;
                if(n > 0){
                    let x: Nat = n - 1;
                    get(l, x);
                }else{
                    ?t;
                };
            };
        };
    };
} 