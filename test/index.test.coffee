should = require 'should'
timeFormat = require '../src'

describe "time-format", ->
  describe "span()", ->
    # Past tests.
    it "should format now ~ a few seconds ago", ->
      now = new Date()
      timeFormat.span(now).should.equal "A few seconds ago"
    # Future tests
    it "should format in a few seconds", ->
      for i in [1..1000]
        inFewSeconds = new Date()
        inFewSeconds.setSeconds inFewSeconds.getSeconds() + Math.ceil(Math.random() * 4)
        timeFormat.span(inFewSeconds).should.equal "In a few seconds"
    # More tests to come...