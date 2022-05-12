# NordCloud test app
## _Stack used:_
- UIKit
- Autolayout
- URLSession
- async/await approach
## Introduction
Glad to present simple test app, made for NordCloud company.
## Explanations
Due to dramatically lack of time I made few not obvious decisions.
There were 3 options to choose making bottomSheet controller:
1. Write custom presentation/transition controller.
2. Use as child view controller.
3. Use system pageSheet modal presentation style.

So as I mentioned before, due to lack of time I decided to use system one (option 3), everything is fine with it, but I faced the problem of custom height of presenting controller. I've solved this problem in very interesting way. (Take a look to imported bridging headers)

Regarding to data persistancy there were 2 options of packing data:
1. Classic approach, with few entities and relationships over them.
2. One entity with id field and another field of data where I can encode received from network codable objects.

Second option looks pretty simple and fast to make, neverthereless I decided to choose first option to compensate my lazyness in my previous decision, because I feel that second one is pretty "dirty" approach.



## Screenshots
![](https://i.ibb.co/Yp39jpG/ezgif-com-gif-maker-3.gif)

# IMPORTANT
Actually I can't see this sluttering with rounded corners during normal run. Tell me If I wrong.
# WARNING
During build phase I can see such an error:

![](http://dl4.joxi.net/drive/2022/05/12/0053/3286/3517654/54/5ae7697e04.jpg)
Don't care and run the project again. It happens due to Obj-C headers bridging. I'll try to fix this problem later, just never had a deal with obj-c.

## Thanks for your attention!
