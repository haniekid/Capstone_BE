using backend.Models;

namespace backend.Repositories
{
	public interface IRepository<T>
	{
		IEnumerable<T> GetAll();
		T GetById(int id);
		bool Add(T item);
		bool Update(T item);
		bool Delete(int id);
		IEnumerable<T> GetById2(int id);
		bool Add2(int id1, int id2);

	}
}
