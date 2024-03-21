using System.Diagnostics.Metrics;
using System.Reflection;

namespace TestTalentZ
{
    public class UnitTest1
    {
        [Fact]
        public void CounterButtonTextUpdatesCorrectly()
        {
            int count = 0;
            string buttonText = "";
            int expectedCountAfterClick = 1;
            string expectedButtonTextAfterClick = "Clicked 1 time";

            count++;
            if (count == 1)
                buttonText = $"Clicked {count} time";
            else
                buttonText = $"Clicked {count} times";

            Assert.Equal(expectedCountAfterClick, count);
            Assert.Equal(expectedButtonTextAfterClick, buttonText);
        }
    }
}