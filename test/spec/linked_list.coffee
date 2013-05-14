'use strict'

describe 'LinkedList', ->
  describe 'traversing', ->
    it 'should traverse the list', ->
      ll = new LinkedList
      ll.insert(1)
      ll.insert(3)
      ll.insert(4)
      ll.insert(2)
      ll.insert(6)
      expect(ll.tail().getValue()).toEqual(6)
      expect(ll.head().getValue()).toEqual(1)
      expect(ll.getValue()).toEqual(1)
      expect(ll.next().next().getValue()).toEqual(4)
      expect(ll.getValue()).toEqual(3)
      expect(ll.next().next().next().getValue()).toEqual(6)
    it 'should traversing the list backwards',->
      ll = new LinkedList
      ll.insert(1).insert(3).insert(4).insert(2).insert(6)
      ll.next().next()
    it 'should Throw Error on empty list traversal', ->
      ll = new LinkedList
      expect(->ll.next()).toThrow(new Error('Index Out of Bounds'))
      expect(->ll.prev()).toThrow(new Error('Index Out of Bounds'))
  
  describe 'operations', ->
    it 'should deleting from the list',->
      ll = new LinkedList
      ll.insert(1)
      ll.insert(3)
      ll.insert(4)
      ll.insert(2)
      ll.insert(6)
      expect(ll.length).toEqual(5)
      ll.next().next().delete()
      expect(ll.head().next().next().getValue()).toEqual(2)
      expect(ll.length).toEqual(4)
    it 'should inserting into the list',->
      ll = new LinkedList
      ll.insert(1)
      expect(ll.length).toEqual(1)
      expect(ll.getValue()).toEqual(1)
   