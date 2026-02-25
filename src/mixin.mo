import ICRC10 ".";

mixin() {
  
  stable var icrc10_collection = ICRC10.initCollection();

  func icrc10_register(entry: ICRC10.Entry) : () {
    ICRC10.register(icrc10_collection, entry);
  };

  public query func icrc10_supported_standards() : async ICRC10.Response {
    return ICRC10.respond(icrc10_collection);
  };
};
