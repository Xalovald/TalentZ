using talentz_api.Models;

namespace talentz_api.Helpers
{
    public interface IComparer<T> : IEqualityComparer<T>
    {}
    public class IdComparer<T> : IComparer<T>
    {
        public bool Equals(T? x, T? y)
        {
            var idProperty = typeof(T).GetProperty("Id");
            return idProperty!.GetValue(x)!.Equals(idProperty!.GetValue(y));
        }

        public int GetHashCode(T obj)
        {
            var idProperty = typeof(T).GetProperty("Id");
            return idProperty!.GetValue(obj)!.GetHashCode();
        }
    }
}
