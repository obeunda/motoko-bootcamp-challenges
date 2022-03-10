import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import MyList "list"

actor day_4 {

    type Student = Custom.MotokoStudent;

    type Animal = Animal.Animal;


    let student: Student = {
        name = "cailro";
        team = "handsome foxes";
        graduate = false;
    };

    let animal: Animal = {
        specie = "Dog";
        energy = 10;
    };

    var list = List.nil<Animal>();

    public query func fun(): async Text {
        var graduate: Text = if (student.graduate) { "graduate" } else {"not yet graduate"};
        return "The Motoko Bootcamp student, " # student.name # " from " # student.team # " team is " # graduate;
    };

    public query func create_animal_then_takes_a_break(specie: Text, energy: Nat): async Animal {
        let animal = {
            specie = specie;
            energy = energy;
        };
        return Animal.animal_sleep(animal);
    };

    public query func push_animal(animal: Animal): async (){
        list := List.push<Animal>(animal, list);
    };

    public query func get_animals(): async [Animal]{
        return List.toArray<Animal>(list);
    };


    public query func last(l: MyList.List<Nat>): async ?Nat{
        return MyList.last<Nat>(l);
    };

    public query func size(l: MyList.List<Nat>): async Nat{
        return MyList.size<Nat>(l);
    };

    public query func get(l: MyList.List<Nat>, i: Nat): async ?Nat{
        return MyList.get<Nat>(l, i);
    }; 

};
