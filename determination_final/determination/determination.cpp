// determination.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"

void CreateDotFile(const string& fileName, vector<vector<int>>& table, const vector<int>& finalState)
{
	ofstream ofs(fileName);

	stringstream stream;
	for (size_t index = 0; index < finalState.size(); ++index)
	{
		stream << finalState[index] << " ";
	}
	ofs << "digraph G {" << endl;
	ofs << "node [shape = doublecircle];" << stream.str() << ";" << endl;
	ofs << "node [shape = circle];" << endl;

	for (size_t index = 0; index < table.size(); ++index)
	{
		for (size_t jindex = 0; jindex < table[index].size(); ++jindex)
		{
			if (table[index][jindex] == -1) { continue; }
			ofs << index << " -> " << table[index][jindex] << " [ label = \"" << jindex << "\" ];" << endl;
		}
	}
	ofs << "}" << endl;
}

vector<vector<vector<int>>> GetStates(istream& stream, int countState, int countX)
{
	auto rowOfTable = vector<vector<int>>(countX, vector<int>());
	auto result = vector<vector<vector<int>>>((size_t)countState, rowOfTable);
	string row;
	getline(stream, row);
	for (size_t index = 0; index < result.size(); ++index)
	{
		if (getline(stream, row))
		{
			if (row.empty() == false)
			{
				stringstream stream(row);
				while (!stream.eof())
				{
					int state, output;
					stream >> state;
					stream >> output;
					result[index][output].push_back(state);
					sort(result[index][output].begin(), result[index][output].end());
				}
			}
		}
	}
	return result;
}

vector<int> GetFinalState(istream& stream, int countFinalState)
{
	vector<int> result;
	for (int index = 0; index < countFinalState; ++index)
	{
		int param;
		stream >> param;
		result.push_back(param);
	}
	return result;
}

vector<vector<int>> MergeState(vector<vector<int>>& lhs, const vector<vector<int>>& rhs)
{
	for (size_t index = 0; index < lhs.size(); ++index)
	{
		auto& first = lhs[index];
		auto second = rhs[index];
		for (size_t j = 0; j < second.size(); ++j)
		{
			if (find(first.begin(), first.end(), second[j]) == first.end())
			{
				first.push_back(second[j]);
			}
		}
		sort(first.begin(), first.end());
	}
	return lhs;
}

vector<vector<int>> MakeState(const vector<vector<vector<int>>>& states, vector<int> indexOfStates, vector<vector<int>>& queue)
{
	auto result = states[indexOfStates.front()];
	for (size_t index = 1; index < indexOfStates.size(); ++index)
	{
		result = MergeState(result, states[indexOfStates[index]]);
	}
	for (auto& item : result)
	{
		if (!item.empty() && find(queue.begin(), queue.end(), item) == queue.end())
		{
			queue.push_back(item);
		}
	}
	return result;
}

int Find(vector<vector<int>>& queue, const vector<int>& search)
{
	for (size_t index = 0; index < queue.size(); ++index)
	{
		auto item = queue[index];
		if (item == search)
		{
			return (int)index;
		}
	}
	return -1;
}

bool isFinalState(vector<int>& finalState, vector<int>& search)
{
	for (auto state : search)
	{
		if (find(finalState.begin(), finalState.end(), state) != finalState.end())
		{
			return true;
		}
	}
	return false;
}

int main()
{
	ifstream in("in3.txt");
	ofstream out("out333.txt");
	if (!in.is_open() || !out.is_open())
	{
		cout << "Files aren't open." << endl;
		return 1;
	}
	int countX, countState, countFinalState;
	in >> countX;
	in >> countState;
	in >> countFinalState;
	vector<int> finalState = GetFinalState(in, countFinalState);
	vector<int> newFinalState;
	auto stateList = GetStates(in, countState, countX);
	vector<vector<int>> newStateList;
	vector<vector<int>> queue;
	vector<int> startState = { 0 };
	queue.push_back(startState);
	if (isFinalState(finalState, startState))
	{
		newFinalState.push_back(0);
	}

	for (size_t index = 0; index < queue.size(); ++index)
	{
		auto& state = queue[index];
		vector<int> result;
		auto newState = MakeState(stateList, state, queue);

		for (auto item : newState)
		{
			auto it = Find(queue, item);
			if (isFinalState(finalState, item) && find(newFinalState.begin(), newFinalState.end(), it) == newFinalState.end())
			{
				newFinalState.push_back(it);
			}
			result.push_back(it);
		}
		newStateList.push_back(result);
	}
	out << countX << endl;
	out << stateList.size() << endl;
	out << newFinalState.size() << endl;
	for (size_t index = 0; index < newFinalState.size(); ++index)
	{
		out << newFinalState[index] << " ";
	}
	out << endl;
	for (size_t index = 0; index < newStateList[0].size(); ++index)
	{
		for (const auto& row : newStateList)
		{
			out << row[index] << " ";
		}
		out << endl;
	}
	CreateDotFile("test333.dot", newStateList, newFinalState);
	return 0;
}

// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода, или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.
