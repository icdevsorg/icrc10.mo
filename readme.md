# ICRC10.mo


A simple library for managing ICRC-10 compliance.


Usage
```

import ICRC10 "mo:icrc10-mo";

shared ({ caller = _owner }) actor class Token  (
    init_args : ICRC1.InitArgs,
) = this{

  stable var supportedStandards = ICRC10.initCollection();


  public func(msg) init() : async(){
    assert(msg.caller == this);

    for(thisItem in ICRC1.supportedStandards){
      ICRC10.register(supportedStandards, thisItem);
    };
  };

  public query icrc10_supported_standards() : ICRC10.Response{
    ICRC10.respond(supportedStandards);
  };

};


```