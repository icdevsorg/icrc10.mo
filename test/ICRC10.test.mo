import { test; suite } "mo:test";

import ICRC10 "../src/lib";

func containsEntry(response : ICRC10.Response, expected : ICRC10.Entry) : Bool {
  for (entry in response.vals()) {
    if (entry.name == expected.name and entry.url == expected.url) {
      return true;
    };
  };

  false;
};

func findByName(response : ICRC10.Response, name : Text) : ?ICRC10.Entry {
  for (entry in response.vals()) {
    if (entry.name == name) {
      return ?entry;
    };
  };

  null;
};

let icrc1 : ICRC10.Entry = {
  name = "ICRC-1";
  url = "https://github.com/dfinity/ICRC/ICRCs/ICRC-1";
};

let icrc2 : ICRC10.Entry = {
  name = "ICRC-2";
  url = "https://github.com/dfinity/ICRC/ICRCs/ICRC-2";
};

let icrc10V1 : ICRC10.Entry = {
  name = "ICRC-10";
  url = "https://github.com/icdevsorg/icrc10.mo/tree/v1";
};

let icrc10V2 : ICRC10.Entry = {
  name = "ICRC-10";
  url = "https://github.com/icdevsorg/icrc10.mo/tree/v2";
};

suite(
  "ICRC-10 library",
  func() {
    test(
      "initCollection starts empty",
      func() {
        let collection = ICRC10.initCollection();
        let response = ICRC10.respond(collection);

        assert response.size() == 0;
      },
    );

    test(
      "register stores a single standard",
      func() {
        let collection = ICRC10.initCollection();
        ICRC10.register(collection, icrc1);

        let response = ICRC10.respond(collection);

        assert response.size() == 1;
        assert containsEntry(response, icrc1);
      },
    );

    test(
      "register keeps multiple distinct standards",
      func() {
        let collection = ICRC10.initCollection();
        ICRC10.register(collection, icrc1);
        ICRC10.register(collection, icrc2);

        let response = ICRC10.respond(collection);

        assert response.size() == 2;
        assert containsEntry(response, icrc1);
        assert containsEntry(response, icrc2);
      },
    );

    test(
      "register replaces an existing standard with the same name",
      func() {
        let collection = ICRC10.initCollection();
        ICRC10.register(collection, icrc10V1);
        ICRC10.register(collection, icrc10V2);

        let response = ICRC10.respond(collection);

        assert response.size() == 1;

        switch (findByName(response, "ICRC-10")) {
          case (?entry) {
            assert entry.url == icrc10V2.url;
          };
          case (null) {
            assert false;
          };
        };
      },
    );

    test(
      "respond returns a snapshot of the current collection state",
      func() {
        let collection = ICRC10.initCollection();
        ICRC10.register(collection, icrc1);

        let before = ICRC10.respond(collection);

        ICRC10.register(collection, icrc2);

        let after = ICRC10.respond(collection);

        assert before.size() == 1;
        assert containsEntry(before, icrc1);
        assert not containsEntry(before, icrc2);

        assert after.size() == 2;
        assert containsEntry(after, icrc1);
        assert containsEntry(after, icrc2);
      },
    );
  },
);