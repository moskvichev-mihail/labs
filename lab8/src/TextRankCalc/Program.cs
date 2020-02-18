using System;
using StackExchange.Redis;
using System.Text.RegularExpressions;
using consts;
using Newtonsoft.Json;



namespace TextRankCalc
{
    class Program
    {
        static void Main(string[] args)
        {
            var subsc = DB.redis.GetSubscriber();
            subsc.Subscribe(Event.TEXT_PROCESSED, (channel, jsonData) => {
                ResultOfTextProcess resultData = JsonConvert.DeserializeObject<ResultOfTextProcess>(jsonData);
                if (resultData.status)
                {
                    string m_id = resultData.id;
                    IDatabase db = DB.redis.GetDatabase();
                    Console.WriteLine($"Region: {Consts.GetRegionToView(Consts.GetRegionCode(db.StringGet(m_id)))}");
                    Console.WriteLine($"Id: {m_id}");
                    db.ListLeftPush( Consts.QUEUE_NAME_COUNTER, m_id, flags: CommandFlags.FireAndForget );
                    db.Multiplexer.GetSubscriber().Publish( Consts.QUEUE_CHANNEL_COUNTER, "" );
                }
            });
            Console.ReadKey();
        }
    }
}
