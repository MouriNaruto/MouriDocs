using Mile.Project.Helpers;
using System.Text;

namespace Translator
{
    internal class Program
    {
        static string RepositoryRootPath = GitRepository.GetRootPath();


        static void TranslateDocument17()
        {
            string DocumentRootPath = Path.Combine(
                RepositoryRootPath,
                 @"docs\17");

            Console.WriteLine(
                "Document: {0}",
                DocumentRootPath);

            string EnglishContent = File.ReadAllText(
                Path.Combine(DocumentRootPath, "ReadMe.md"),
                Encoding.UTF8);

            string ChineseContent = EnglishContent;
            ChineseContent = ChineseContent.Replace(
                "# MD17: Windows Kits Download Link Summary",
                "# MD17: Windows 开发者资源下载链接汇总");
            ChineseContent = ChineseContent.Replace(
                "[简体中文](ReadMe.zh-CN.md)",
                "[English](ReadMe.md)");
            ChineseContent = ChineseContent.Replace(
                "Version",
                "版本");
            ChineseContent = ChineseContent.Replace(
                "Link",
                "链接");
            ChineseContent = ChineseContent.Replace(
                "References",
                "参考资料");

            FileUtilities.SaveTextToFileAsUtf8Bom(
                Path.Combine(DocumentRootPath, "ReadMe.zh-CN.md"),
                ChineseContent);
        }

        static void Main(string[] args)
        {
            Console.WriteLine(
                "Repository: {0}",
                RepositoryRootPath);

            TranslateDocument17();

            Console.WriteLine(
               "MouriDocs.TranslationGenerator task has been completed.");
            Console.ReadKey();
        }
    }
}
