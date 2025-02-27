using System.Linq.Expressions;

namespace talentz_api.Helpers
{
    public class Initializer<T>(T instance)
    {
        private readonly T _instance = instance;
        private readonly Dictionary<string, object> _propertyValues = new();
        private readonly string? Message;

        public Initializer<T> SetProperty<TValue>(Expression<Func<T, TValue>> propertyExpression, TValue value)
        {
            MemberExpression memberExpression = (MemberExpression)propertyExpression.Body;
            string propertyName = memberExpression.Member.Name;
            _propertyValues[propertyName] = value!;
            return this;
        }

        public Initializer<T> WithMessage(string message)
        {
            _propertyValues[nameof(Message)] = message;
            return this;
        }

        public static implicit operator T(Initializer<T> initializer)
        {
            var instance = initializer._instance;

            foreach (var keyValue in initializer._propertyValues)
            {
                var property = typeof(T).GetProperty(keyValue.Key);
                property!.SetValue(instance, keyValue.Value);
            }

            return instance;
        }
    }
    public static class Initializer
    {
        public static Initializer<T> Initialize<T>(T instance)
        {
            return new Initializer<T>(instance);
        }
    }
}
