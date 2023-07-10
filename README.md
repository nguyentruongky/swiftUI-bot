Hi, please check my implementation for the assignment.

I created a protocol contains list of actions to connect to API server. Every action is a worker (SendMessageWorker for instance) to handle a separate API. With this way, I want to reduce code for the Service class (which conform to the list of actions).