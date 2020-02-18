using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using StackExchange.Redis;
using consts;

namespace TextStatistic
{
    class Program
    {
        private static int countBadRequests;
        private static Double rank;
        private static int allCountOfText;
        private static int countTextsWithHighRate;
        private static Double avgRank;
        private static void SendDataToDB()
        {
            TextStatisticData textStatistic = new TextStatisticData();
            textStatistic.countOfText = allCountOfText;
            textStatistic.avarageRank = avgRank;
            textStatistic.countOfTextWithHightRank = countTextsWithHighRate;
            textStatistic.countRejectedRequests = countBadRequests;
            DB.redis.GetDatabase().StringSet("text_statistic", JsonConvert.SerializeObject(textStatistic));
        }
        static void Main(string[] args)
        {
            var subsc = DB.redis.GetSubscriber();
            subsc.Subscribe(Consts.TEXT_RANK_CALCULATED, (channel, message) => {
                DataToStatistic statisticMessage = JsonConvert.DeserializeObject<DataToStatistic>(message);
                Console.WriteLine(message);
                rank += statisticMessage.rate;
                allCountOfText++;

                if (statisticMessage.rate > 0.5)
                {
                    countTextsWithHighRate++;
                }

                avgRank = rank / allCountOfText;
                
                Console.WriteLine($"countOfText: {allCountOfText}  highRankPart: {countTextsWithHighRate}+ avgRank: {avgRank}");
                SendDataToDB();
            });

            subsc.Subscribe(Event.TEXT_PROCESSED, (channel, jsonData) => {
                ResultOfTextProcess resultData = JsonConvert.DeserializeObject<ResultOfTextProcess>(jsonData);
                if (!resultData.status)
                {
                    countBadRequests++;
                    SendDataToDB();
                }
            });

            Console.ReadKey();
        }
    }
}
