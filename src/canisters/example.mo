import ICRC10Mixin "../mixin";

shared ({ caller = _owner }) persistent actor class Token() = this {

  include ICRC10Mixin();

  public shared(_msg) func init() : async () {
    icrc10_register({name = "ICRC-7"; url = "https://github.com/dfinity/ICRC/ICRCs/icrc7/"});
  };
};
