using System;

namespace BookLibrary.Core.Data
{
    public static class CommonFunctions
    {
        public static string CreatePictureUri(string path, string fileName, string fileExtension)
        {
            return path + fileName + fileExtension;
        }
    }
}
