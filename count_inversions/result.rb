# Download the text file here(http://spark-public.s3.amazonaws.com/algo1/programming_prob/IntegerArray.txt). (Right click and save link as)
# This file contains all of the 100,000 integers between 1 and 100,000 (inclusive) in some order, with no integer repeated.

# Your task is to compute the number of inversions in the file given, where the ith row of the file indicates the ith entry of an array.
# Because of the large size of this array, you should implement the fast divide-and-conquer algorithm covered in the video lectures. The numeric answer for the given input file should be typed in the space below.
# So if your answer is 1198233847, then just type 1198233847 in the space provided without any space / commas / any other punctuation marks. You can make up to 5 attempts, and we'll use the best one for grading.
# (We do not require you to submit your code, so feel free to use any programming language you want --- just type the final numeric answer in the following space.)

# [TIP: before submitting, first test the correctness of your program on some small test files or your own devising. Then post your best test cases to the discussion forums to help your fellow students!]


def countInversion(inputArray)
  results = countInversionHelper(inputArray, 0, inputArray.length)
  results[0]
end

def countInversionHelper(inputArray, startIndex, endIndex)
  return [0, [inputArray[startIndex]]] if endIndex - startIndex == 1

  half = startIndex + (endIndex - startIndex) / 2
  firstHalf = countInversionHelper(inputArray, startIndex, half)
  secondHalf = countInversionHelper(inputArray, half, endIndex)

  crossCount = countSplit(firstHalf[1], secondHalf[1])

  totalCount = firstHalf[0] + secondHalf[0] + crossCount[0]
  [totalCount, crossCount[1]]
end

def countSplit(firstArray, secondArray)
  count = 0
  resultArray = []
  i = 0
  j = 0
  k = 0
  firstLength = firstArray.length
  secondLength = secondArray.length
  totalLength = firstLength + secondLength

  for k in 0...totalLength
    if i == firstLength
      resultArray.push(secondArray[j])
      j += 1
    elsif j == secondLength
      resultArray.push(firstArray[i])
      i += 1
    elsif firstArray[i] < secondArray[j]
      resultArray.push(firstArray[i])
      i += 1
    else
      count += firstLength - i
      resultArray.push(secondArray[j])
      j += 1
    end
  end

  [count, resultArray]
end

## Read input array
inputArray = []
file = File.new("integerArray.txt", "r")
while (line = file.gets)
    inputArray.push(line.to_i)
end
file.close

testResult = countInversion([1,3,5,2,4,6])
puts "#{testResult} should be 3"
testResult = countInversion([1,5,3,2,4])
puts "#{testResult} should be 4"
testResult = countInversion([5,4,3,2,1])
puts "#{testResult} should be 10"
testResult = countInversion([1,6,3,2,4,5])
puts "#{testResult} should be 5"
puts "#{countInversion(inputArray)}"
