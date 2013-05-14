'use strict'

describe 'SortedArray', ->
  sa = undefined
  beforeEach ->
    sa = new SortedArray

  it 'should respond to toArray', ->
    expect(sa.toArray()).toEqual []

  it 'should have the ablity to push Elements into array', ->
    sa.push 3
    expect(sa.peek()).toEqual 3

  it 'should have the ablity to push Elements into array In Order', ->
    sa.push 3
    sa.push 2
    sa.push 5
    sa.push 6
    sa.push 8
    sa.push 7
    sa.push 4
    expect(sa.toArray()).toEqual [ 2, 3, 4, 5, 6, 7, 8 ]

  it 'should resort objects', ->
    sa.push {val: 2}
    sa.push {val: 3}
    sa.setCallback (a, b) -> a.val > b.val
    sa.push {val: 5}
    sa.push {val: 6}
    expect(sa.toArray()).toEqual [ {val: 6}, {val: 5}, {val: 3}, {val: 2} ]


  it 'should know the current Size', ->
    sa.push {val: 2}
    sa.push {val: 3}
    expect(sa.size()).toBe 2


  it 'should be able to remove element ', ->
    sa.push {val: 2}
    sa.push {val: 3}
    sa.push {val: 4}
    sa.push {val: 5}
    expect(sa.size()).toBe 4
    sa.remove sa.seek(2)
    sa.remove { val: 3 }
    expect(sa.toArray()).toEqual [{ val : 2 }, { val : 5 } ]

  it 'should have a overridable array', ->
    sa = new SortedArray (a, b) -> a > b
    sa.push 3
    sa.push 2
    sa.push 5
    sa.push 6
    sa.push 8
    sa.push 7
    sa.push 4
    expect(sa.toArray()).toEqual [ 8, 7, 6, 5, 4, 3, 2 ]

  it 'should sort objects', ->
    sa = new SortedArray (a, b) -> a.val > b.val
    sa.push {val: 3}
    sa.push {val: 2}
    sa.push {val: 5}
    sa.push {val: 6}
    sa.push {val: 8}
    sa.push {val: 7}
    sa.push {val: 4}
    expect(sa.toArray()).toEqual [ {val: 8}, {val: 7}, {val: 6}, {val: 5}, {val: 4}, {val: 3}, {val: 2} ]
