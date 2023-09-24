# kinship-verification-from-facial-images

first, all images have been divided to 5 folds. each time, 1 fold selected as test and the 4 other folds selected as training folds.

LBP and HOG features extracted from each fold and then concatenated.then I calculated chi-square distance between these features for each twp images (kin or not kin).

for training, I used Support Vector Machines with these distance vectors.

for each fold, I calculate the accuracy and then final accuracy was the average of the acuuracies.
