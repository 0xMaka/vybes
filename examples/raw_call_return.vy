
@external
def foo(_foo: address) -> uint256:
  response: Bytes[32] = raw_call(
    _foo,
    method_id("bar()"),
    max_outsize=32
  )
  return convert(response, uint256)

@external
@view
def bar() -> uint256:
  return 123987456321
