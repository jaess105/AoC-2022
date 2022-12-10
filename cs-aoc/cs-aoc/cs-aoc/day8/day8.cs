using System.Data;
using System.Linq;

namespace cs_aoc.day8
{

    internal class Tree
    {
        public int Height { get; set; }
        public bool Visible { get; set; }
        public int VisibleTrees { get; set; }
        public override string ToString() => "(" + Height + "," + Visible + "," + VisibleTrees + ")";

    }

    static class Day8
    {
        static string DAY8_CONTENT = Properties.Resources.day8;
        static string DAY8_TEST_CONTENT = Properties.Resources.day8_test;
        public static void Day1()
        {
            var lines = DAY8_CONTENT.Split("\r\n");
            var res1 = Task1(lines);
            var res2 = Task2(lines);
            // 1805
            Console.WriteLine("Day 8 task 1: {0}", res1);
            Console.WriteLine("Day 8 task 2: {0}", res2);
        }

        static int Task2(string[] lines)
        {
            var visibleTrees = GenerateTrees(lines);
            return (from Tree tree in visibleTrees
                        //orderby tree.VisibleTrees
                    select tree
                    ).MaxBy(keySelector: x => x.VisibleTrees)?.VisibleTrees ?? 0;
        }

        static int Task1(string[] lines)
        {
            var visibleTrees = GenerateTrees(lines);

            return (from Tree tree in visibleTrees
                    where tree.Visible
                    select tree)
                    .Count();
        }

        static Tree[,] GenerateTrees(string[] lines)
        {
            var visibleTrees = new Tree[lines.Length, lines[0].Length];

            for (var i = 0; i < lines.Length; i++)
            {
                for (var j = 0; j < lines[i].Length; j++)
                {
                    int height = (int)Char.GetNumericValue(lines[i][j]);
                    visibleTrees[i, j] = new Tree { Height = height, Visible = false, VisibleTrees = 1 };
                    if (i == 0 || i == lines.Length - 1
                         || j == 0 || j == lines[i].Length - 1)
                    {
                        visibleTrees[i, j].Visible = true;
                        visibleTrees[i, j].VisibleTrees = 0;
                    }
                }
            }
            for (var i = 1; i < lines.Length - 1; i++)
            {
                for (var j = 1; j < lines[i].Length - 1; j++)
                {
                    var current = visibleTrees[i, j];

                    current.VisibleTrees *= LookToTheLeft(visibleTrees, current, i, j);
                    current.VisibleTrees *= LookUp(visibleTrees, current, i, j);
                    current.VisibleTrees *= LookDown(visibleTrees, current, lines.Length, i, j);
                    current.VisibleTrees *= LookToTheRight(visibleTrees, current, lines[i].Length, i, j);
                }
            }
            return visibleTrees;
        }

        static int LookToTheLeft(Tree[,] visibleTrees, Tree current, int i, int j)
        {
            // looking to the left
            int k = j - 1;
            for (; k > 0 && current.Height > visibleTrees[i, k].Height; k--)
                ;
            if (k == 0 && current.Height > visibleTrees[i, k].Height)
            {
                current.Visible = true;
            }
            return j - k;
        }

        static int LookUp(Tree[,] visibleTrees, Tree current, int i, int j)
        {
            // looking from the top
            int k = i - 1;
            for (; k > 0 && current.Height > visibleTrees[k, j].Height; k--)
                ;
            if (k == 0 && current.Height > visibleTrees[k, j].Height)
            {
                current.Visible = true;
            }
            return i - k;
        }

        static int LookDown(Tree[,] visibleTrees, Tree current, int colLen, int i, int j)
        {
            // looking down
            int k = i + 1;
            for (; k < colLen - 1 && current.Height > visibleTrees[k, j].Height; k++)
                ;
            if (k == colLen - 1 && current.Height > visibleTrees[k, j].Height)
            {
                current.Visible = true;
            }
            return k - i;
        }

        static int LookToTheRight(Tree[,] visibleTrees, Tree current, int rowLen, int i, int j)
        {
            // looking to the right
            int k = j + 1;
            for (; k < rowLen - 1 && current.Height > visibleTrees[i, k].Height; k++)
                ;
            if (k == rowLen - 1 && current.Height > visibleTrees[i, k].Height)
            {
                current.Visible = true;
            }
            return k - j;
        }
    }
}
