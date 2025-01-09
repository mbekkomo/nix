{ root, ... }:
{
  interval_ms = 5000;

  reminder = {
    threshold = 30;
    title = "don't forget to charge :3";
    content = "your battery percentage is 30%, don't forget to charge";
  };

  warn = {
    threshold = 15;
    title = "uhhh, he's going to die =w=";
    content = "charge your laptop or he's going to die die";
  };

  threat = {
    threshold = 5;
    title = "uh oh, he's dying TwT";
    content = "charge him now!";
  };
}
