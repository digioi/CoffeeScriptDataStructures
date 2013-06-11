'use strict'
class LinkedList
  constructor: (@currentNode, @headNode, @tailNode)-> @length = 0
  getValue: -> @currentNode.getValue()
  current: -> @currentNode
  head:    -> @currentNode = @headNode
  tail:    -> @currentNode = @tailNode
  next: (roundRobin)->
    if @currentNode?.next()?
      @currentNode = @currentNode.next()
    else if roundRobin && @headNode
      @currentNode=@headNode
    else
      throw new Error('Index Out of Bounds')

  prev: (roundRobin)->
    if @currentNode?.prev()?
      @currentNode = @currentNode.prev()
    else if roundRobin && @tailNode
      @currentNode=@tailNode
    else
      throw new Error('Index Out of Bounds')

  insert: (obj)->
    node = new LinkedNode(obj, @, @tailNode)
    @tailNode.setNext(node) if @tailNode?
    @headNode = node        unless @headNode?
    @currentNode = node     unless @currentNode?
    @tailNode = node
    @length += 1
    @

  delete: ->
    deleteNode = @currentNode.deleteNode()
    @length -= 1
    if deleteNode != @tailNode
      @currentNode = deleteNode.next()
    else if deleteNode != @headNode
      @currentNode = deleteNode.prev()
    else
      @currentNode = null
  
  setCurrent: (node)->
    @currentNode = node
    @

class LinkedNode
  constructor: (@value, @list, @previousNode, @nextNode)->
  getValue: -> @value
  prev: -> @prevNode
  setPrev: (@prevNode)->
  next: -> @nextNode
  setNext: (@nextNode)->
  delete: ->
    @list.setCurrent(@).delete()
  deleteNode: ->
    @previousNode.nextNode = @nextNode
    @previousNode.prevNode = @prevNode
    @