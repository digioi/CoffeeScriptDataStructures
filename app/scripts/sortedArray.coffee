# @author Michael DiGioia
# @version v0.0.1

###
 * Class for Creating SortedArrays in Javascript
###
class SortedArray
  # Construct a new sorted array.
  #
  # @param [Array] Initial list of Array
  # @param [Callback] (newElement, existingElement) comparision function
  #
  constructor: (@array=[], @sortCallBack)->
    if typeof @array is 'function'
      @sortCallBack = @array
      @array = []
    @sortCallBack ||= (newElem, currentIndexElement)-> 
      newElem < currentIndexElement
    @__resortArray() if @size() > 0
    
  # @returns Current numbers of objects stored
  size: ->
    @array.length

  # Resets the callback and resorts the array
  setCallback: (@sortCallBack)->
    @__resortArray()

  # Resets the Array to the array provided
  setArray: (array)->
    @array = @toArray()
    for elem in array
      @push elem

  # Pushes new element into its position in the Array
  # @params [elem] Element to put into array
  # @params [quiet] If set to true appends element to end of list else throws an error
  push: (elem, quiet=false)->
    index = 0
    try 
      while !found? && (element = @seek(index))?
        if @sortCallBack(elem, element)
          found = true
        else 
          index += 1 
      @array.splice index, 0, elem
    catch Exception
      if quiet
        @array.push elem
      else
        throw Exception
  
  # Displays Element at provided index
  # @params [index] Element Index to Display
  seek: (index)->
    @array[index]

  # Displays the First Element in the Array
  peek: ->
    @seek(0)

  # Returns a cloned array
  toArray: ->
    @array.slice 0

  # Removes Object from Array
  # @params [object] Object that should be removed from array
  remove: (obj)->
    index = 0
    lastSeek = null
    while !exit?
      lastSeek = @seek(index)
      if !lastSeek? || @__obj_equal(lastSeek, obj)
        exit = true 
      else
        index += 1
    @pop(index) if lastSeek?
  
  # Removes Index from Array
  # @params [index] index to remove defaults to first index
  pop: (index=0)->
    @array.splice index, 1
    
  #__private__#
  __obj_equal: (first, second)->
   JSON.stringify(first) == JSON.stringify(second)

  __resortArray: ->
    currentArray = @toArray()
    @array = []
    for elem in currentArray
      @push elem