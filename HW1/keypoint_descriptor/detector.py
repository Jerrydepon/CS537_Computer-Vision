import cv2
import numpy as np
import os
import torch
import random


def writeTxtFile(fileName, keypoints):
    f = open("{0}.txt".format(fileName), "a")
    for (x, y) in keypoints:
        f.write("{0}, {1}\n".format(x, y))
    f.close()


def getPatches(kps, img, size=32, num=500):
    res = torch.zeros(num, 1, size, size)
    if type(img) is np.ndarray:
        img = torch.from_numpy(img)
    h, w = img.shape  # note: for image, the x direction is the verticle, y-direction is the horizontal...
    for i in range(num):
        cx, cy = kps[i]
        cx, cy = int(cx), int(cy)
        dd = int(size / 2)

        xmin, xmax = max(0, cx - dd), min(w, cx + dd) - 1
        ymin, ymax = max(0, cy - dd), min(h, cy + dd) - 1
        xmin_res, xmax_res = dd - min(dd, cx), dd + min(dd, w - cx) - 1
        ymin_res, ymax_res = dd - min(dd, cy), dd + min(dd, h - cy) - 1

        res[i, 0, ymin_res: ymax_res, xmin_res: xmax_res] = img[ymin: ymax, xmin: xmax]
    return res


def getHarrisCorner(image_dir):
    img = cv2.imread(image_dir)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    gray = np.float32(gray)
    dst = cv2.cornerHarris(gray, 2, 21, 0.15)
    cv2.imshow('dst',img)
    return dst > 0.05 * dst.max(), gray


all_patches = torch.zeros(5, 200, 1, 32, 32)
img_dir, files, num = "images", [], 0
for imgFileName in os.listdir(img_dir):
    if not imgFileName.endswith("jpg"):
        continue
    image_dir = os.path.join(img_dir, imgFileName)
    (arr, gray), tmp = getHarrisCorner(image_dir=image_dir), []
    for row in range(len(arr)):
        for col in range(len(arr[0])):
            if arr[row, col]:
                tmp.append((col, row))

    key_points = random.sample(tmp, 200)
    patches = getPatches(key_points, gray, size=32, num=len(key_points))
    all_patches[num] = patches
    num += 1
    writeTxtFile(fileName=imgFileName.replace(".jpg", ""), keypoints=key_points)

output_dir = "{0}.pt".format("933271081_wangchih_keypoints")
torch.save(all_patches, output_dir)
test_patches = torch.load(output_dir)
print(type(test_patches))
print(test_patches[0].shape)