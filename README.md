# Machine-Learning-for-Grain-Assaying

## Our Project Objectives

### What is Assaying

Whenever we buy anything, its quality is usually an important criteria for us. It is but naturaly, who would prefer a poor quality product. So quality testing and certification is important for all products.

Same thing goes for grains. A grain's quality is dependent upon various factors such as its moisture content, foreign particle count, lusture, broken grains count etc. A person buying the grain needs to be sure of its quality as the price paid for the grain is often very dependent upon grain quality. The process of testing for a grain's quality is called assaying.

In this project we will be using machine learning solutions for grain assaying.

### What happens presently after a farmer produces something

Once the farmer produces something, he takes it to the nearest mandi. In a typical mandi, the grain is cleaned and sorted and then it is kept under a shed in the form of heaps. The heap size is not fixed and can vary a lot. Each mandi has a group of licensed traders who then come to the heap, draw a fistful of grain from it, look at it and through their experience, instantly assess the grain quality and then bid for the heap. After this auction, the highest bidder gets to buy the heap.

### Issues with present system

However, there are some issues with this sort of arrangement. The biggest issue is that farmers don't get full price for their crops. Since only a handful of the licensed traders in the mandi can buy from that mandi, there is often cartelisation in the mandis and the farmers get paid very little while the traders sell it to consumers at very high prices. So for instance, while onion may be selling for Rs. 100 / kg in the cities, the farmer growing it might be getting only Rs. 20! Additionally, the present assaying is inherently subjective and can be open to lot of manipulation.


To overcome this, government is starting <a href="http://www.enam.gov.in/NAM/home/index.html">e-National Agriculture Market </a> where any trader in any part of the country would be able to buy from any mandi in the country. This will increase competition and break the cartels and farmers will be able to get better prices.


### Need for this project

This project aims at facilitating the e-NAM. If I am a trader sitting in Chennai and I want to buy wheat from Punjab, I need to be sure that the quality of wheat I am seeing on my screen on the e-NAM portal is actually the quality of wheat which is there in the Punjab mandi. In the present system, I or my agent need to be physically present there to draw a fistful from the heap and assess its quality. But this might not be possible for most of the traders sitting in distant places.

So there needs to be scientific quality assessment of grains. Hence this research project!

### Scope of the project

Although the e-NAM covers some 28 commodities at present, we cannot hope to develop a solution for all 28 at once. So we are starting with the two most widely traded commodities - paddy and wheat. 

The quality parameters for paddy can be found (a href="http://www.enam.gov.in/NAM/infrastructure/Paddy.pdf">here</a>. 

The quality parameters for wheat can be found (a href="http://www.enam.gov.in/NAM/infrastructure/Wheat.pdf">here</a>. 

Although some technologies are available for this, but they are very expensive, cumbersome and require the movement of grain to a laboratory for assaying. But given the rush in the mandi during peak season and availability of resources, such solutions are not easily implementable. So the solution we develop has to compete against the ease, scale, cost and accuracy of the present "fist system of assaying". 

We should be able to click a photo from our smartphone, send it to our server via an android app and within seconds get the response!

Also we understand that purely by looking at the image, we cannot tell all the quality parameters of the grain. Still our endeavor will be to tell as many useful parameters as we can.

### The Problem Statement

Thus problem statement is: "Given images of a sample of grain say wheat, could you tell me how much is the broken grain count, foreign particles etc.?"  

