from __future__ import absolute_import, division, print_function, unicode_literals
from numpy.lib.twodim_base import tri

# TensorFlow and tf.keras
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
from tensorflow.keras.preprocessing.image import ImageDataGenerator

# Helper libraries
import numpy as np
import matplotlib.pyplot as plt

from plots import plot_some_data, plot_some_predictions


fashion_mnist = keras.datasets.fashion_mnist

(train_images, train_labels), (test_images, test_labels) = fashion_mnist.load_data()

class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
               'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

# Scale these values to a range of 0 to 1 before feeding them to the neural network model. 
# To do so, divide the values by 255. 
# It's important that the training set and the testing set be preprocessed in the same way
train_images = train_images / 255.0

test_images = test_images / 255.0

num_of_images = len(train_images)

width = len(train_images[0])

height = len(train_images[0][0])

num_of_channels = 1


# reshape to mum_train_images X height X width X channels, where channels = 1
train_images_reshaped =train_images.reshape(-1,width,height,num_of_channels)
test_images_reshaped = test_images.reshape(-1,width,height,num_of_channels)


# # Build the model
# # Building the neural network requires configuring the layers of the model, then compiling the model.

#Sequential model
model = keras.Sequential()

#conv1
model.add(layers.Conv2D(32, (3, 3),strides=1,padding='same', input_shape=(28, 28, 1)))

#batch norm 1
model.add(layers.BatchNormalization())

model.add(layers.Activation('relu'))


#conv2
model.add(layers.Conv2D(32, (3, 3),strides=1, padding='same', input_shape=(28, 28, 1)))

#batch norm 2
model.add(layers.BatchNormalization())

model.add(layers.Activation('relu'))

#maxPool-1
model.add(layers.MaxPool2D([2,2],padding='valid'))

model.add(layers.Dropout(0.2))

#conv3
model.add(layers.Conv2D(64, (3, 3),strides=1, padding='same', input_shape=(28, 28, 1)))

#batch norm 3
model.add(layers.BatchNormalization())

model.add(layers.Activation('relu'))

#conv4
model.add(layers.Conv2D(64, (3, 3),strides=1, padding='same', input_shape=(28, 28, 1)))

#batch norm 4
model.add(layers.BatchNormalization())

model.add(layers.Activation('relu'))

#maxPool-2
model.add(layers.MaxPool2D([2,2],padding='valid'))

model.add(layers.Dropout(0.3))

#conv5
model.add(layers.Conv2D(128, (3, 3),strides=1, padding='same', input_shape=(28, 28, 1)))

#batch norm 5
model.add(layers.BatchNormalization())

model.add(layers.Activation('relu'))

#maxPool-3
model.add(layers.MaxPool2D([2,2],padding='valid'))

model.add(layers.Dropout(0.4))

#flat layer
model.add(layers.Flatten())

model.add(layers.Dense(200))

#batch norm 6
model.add(layers.BatchNormalization())

model.add(layers.Activation('relu'))

model.add(layers.Dropout(0.5))

model.add(layers.Dense(10))


model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])

#Train the model
# Training the neural network model requires the following steps:

#   1. Feed the training data to the model. In this example, the training data is in the train_images and train_labels arrays.
#   2. The model learns to associate images and labels.
#   3. You ask the model to make predictions about a test set???in this example, the test_images array.
#   4. Verify that the predictions match the labels from the test_labels array.

history = model.fit(train_images_reshaped, train_labels, epochs=50, validation_data=(test_images_reshaped, test_labels))

# Evaluate accuracy
test_loss, test_acc = model.evaluate(test_images_reshaped,  test_labels, verbose=2)

print('\nTest accuracy:', test_acc)

# summarize history for accuracy
plt.plot(history.history['accuracy'])
plt.plot(history.history['val_accuracy'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train_acc', 'test_acc'], loc='upper left')
plt.show()

# Make predictions
# With the model trained, you can use it to make predictions about some images. 
# The model's linear outputs, logits. 
# Attach a softmax layer to convert the logits to probabilities, which are easier to interpret. 
probability_model = tf.keras.Sequential([model, 
                                         tf.keras.layers.Softmax()])

predictions = probability_model.predict(test_images_reshaped)

plot_some_predictions(test_images, test_labels, predictions, class_names, num_rows=5, num_cols=3)





