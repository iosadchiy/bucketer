Bucketer
========

Task description - see below


Installation
------------

```
git clone https://tepoga@github.com/tepoga/bucketer.git
cd bucketer
bundle install
```

To run a few tests:

```
rspec bucketer.rb
```

To run it from command line:

```
ruby bucketer.rb input.txt 3 2
```

Parameters:
* input.txt - file with input data in json format. E.g [1,2,3,4,5]
* 3 - average numbers per bucket
* 2 - spread. Smaller value makes numbers stick together


Algorithm description:
----------------------

Pretty simple: for each element in the input array compute the number
of bucket to put it into. Adjacent elements are likely to get to the
same bucket.

When determining bucket number random value with normal distribution
is used. This gives the 'stick together' behaviour and allows co
configure not only average number of numbers per bucket but aslo the
spread.

Algorithmic complexity is O(n) since we traverse the array only once.

Avg number of items per bucket gets closer to set parameter value with
the increase of (avg_items_per_bucket / total_items) ratio.

Note that buckets in the ouput don't necessarily go in the same order
they were created (no requirement for that provided)

No error handling provided: it's up to the user to ensure that input
file exists and he's not recommended to enter 0 as average number of
items value.


Task description
----------------

Suppose you have a set of photos, all of which have a date taken. Your goal is to create an algorithm that will put the photos into meaningful buckets that can then be used to seed pages in an autoflow’ed book.

For example, if I have 5 photos in my set, and the grouping algorithm creates 2 buckets [[1,4], [2,3,5]], then on page 1 of the book will be photos 1 & 4 and on the next page will be photos 2, 3, & 5.

The algorithm should be non-deterministic and the average number of photos in a set should be adjustable. Also, you can assume that photos that are closer to each other in time proximity are more relevant to each other thus more likely to belong together on the same page. The total number of groups that the algorithm outputs is determined by the algorithm you choose and the input set, not vice-versa. In other words, you cannot specify the number of groups that your algorithm creates before it runs. For example, let’s say you had the following synchronous time events:

`[5, 15, 16, 18, 24]`

Chances are, if you are shooting for an average of 2 photos per page, the algorithm might spit out the following results after being run multiple times:

```
[[5], [15, 16, 18], [24]]
[[5], [15, 16], [18, 24]]
[[5], [15, 16, 18], [24]]
[[5], [15, 16, 18], [24]]
[[5], [15, 16], [18], [24]]
[[5], [15, 16, 18], [24]]
[[5], [15, 16], [18], [24]]
[[5], [15, 16, 18], [24]]
```

Notice how certain results appear more often than others. On any given run, the result could be one of many outcomes, but you tend to see certain outcomes with higher probability. That is not to say we couldn’t get an outcome like [[5], [15], [16], [18], [24]], but there might be a very small chance of it occurring.

Also, please walk me through your logic for choosing you’re algorithm and distributions used. Please use the following data to represent a sequence of linear time. Your output should show how this sequence is grouped so one can understand your algorithms behavior. Please write this algorithm in Ruby and make it so that it can be run from the command line with the outputted groups in the console. Here is the data of time information:

```
[392, 396, 400, 406, 422, 436, 446, 448, 450, 454, 462, 470, 478, 488,
490, 508, 512, 518, 526, 528, 532, 538, 548, 562, 570, 580, 592, 594,
596, 598, 600, 604, 608, 614, 620, 626, 632, 640]
```

Feel free to create additional arrays of numbers to test the corner
cases and verify that your function is behaving as you are expecting
and outputting a result set that a user is most likely to like.

