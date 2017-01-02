#!/usr/bin/env bats

load test_helper
fixtures version

@test "running without a Makefile" {
  run bats "$FIXTURE_ROOT/empty"
  [ $status -eq 0 ]
  [ "$output" = "1..0" ]
}
