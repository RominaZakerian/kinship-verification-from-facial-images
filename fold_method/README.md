# kinship-verification-from-facial-images

test with k-fold method

first, all images have been divided to 5 folds. each time, 1 fold selected as test and the 4 other folds selected as training folds.

LBP and HOG features extracted from each fold and then concatenated. for training, I used Support Vector Machines.
for each fold, I calculate the accuracy and then final accuracy was the average of the acuuracies.
