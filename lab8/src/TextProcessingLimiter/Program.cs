using System;
using consts;
using StackExchange.Redis;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace TextProcessingLimiter
{
    class Program
    {
        static void Main(string[] args)
        {
            int countLimitWords = Convert.ToInt32(args[0]);
            countLimitWords++;

            bool status = false;
            int countWords = 1;

            var subsc = DB.redis.GetSubscriber();
            subsc.Subscribe(Event.TEXT_CREATED, (channel, id) => {
                string check = id;
                if (check.Split(':').Length > 1)
                {
                    countWords--;
                }else
                {    
                    countWords++;
                    status = countWords <= countLimitWords;
                    ResultOfTextProcess limiterData = new ResultOfTextProcess();
                    limiterData.id = id;
                    limiterData.status = status;
                    subsc.Publish(Event.TEXT_PROCESSED, JsonConvert.SerializeObject(limiterData));
                    if (!status)
                        Task.Run(async () => {
                            await Task.Delay(30000);
                            countWords = 0;
                            Console.WriteLine("Reset!");
                        });
                }
            });
            Console.ReadKey();
        }
    }
}
