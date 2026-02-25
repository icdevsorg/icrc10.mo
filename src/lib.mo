import Map "mo:core/Map";
import Iter "mo:core/Iter";
import Text "mo:core/Text";

module {

  public type Entry = {
    name : Text;
    url : Text;
  };

  public type Response = [Entry];

  public type ICRC10Collection = Map.Map<Text, Entry>;

  public func initCollection() : Map.Map<Text, Entry> {
    return Map.empty<Text, Entry>();
  };

  public func register(existingCol: Map.Map<Text, Entry>, newEntry: Entry) : () {
    Map.add(existingCol, Text.compare, newEntry.name, newEntry);
  };

  public func respond(existingCol: Map.Map<Text, Entry>) : Response {
    return Iter.toArray<Entry>(Map.values(existingCol));
  };

};