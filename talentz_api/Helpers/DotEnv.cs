namespace talentz_api.Helpers
{
    public class DotEnv
    {
        public static void Load(string path)
        {
            if (!File.Exists(path))
            {
                return;
            }

            foreach (string line in File.ReadAllLines(path))
            {
                List<string> parts = [.. line.Split('=', StringSplitOptions.RemoveEmptyEntries)];
                if (parts.Count != 2)
                {
                    continue;
                }

                Environment.SetEnvironmentVariable(parts[0], parts[1]);
            }
        }
    }
}
