static int arr[] = {1, 10, 4, 5, 6, 7};
static const int n = sizeof(arr) / sizeof(arr[0]);
static int sum;

void fmain()
{
	int i;

	for(i = 0; i < n; i++)
		sum += arr[i];

	return;
}


int main()
{
	fmain();
	return 0;
}
