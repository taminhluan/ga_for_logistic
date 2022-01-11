noOfCustomers = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]
noOfVehicles = [1 2 3 4 5]
distance = [0	13	15	8	8	12	9	13	10	4	13	6	8	9	14;
12	0	3	17	17	22	20	22	19	11	10	11	8	9	4;
14	3	0	19	19	28	26	29	21	14	10	13	12	11	4;
10	18	21	0	0	13	11	7	4	7	14	8	11	10	19;
10	19	21	0	0	13	11	7	4	7	14	8	11	10	19;
12	24	31	13	13	0	3	10	11	17	24	18	21	20	33;
10	20	27	11	11	3	0	8	9	14	21	16	22	17	29;
12	22	28	7	7	10	8	0	3	11	17	12	14	14	31;
10	20	22	5	5	12	9	2	0	8	15	10	12	11	20;
4	13	14	6	6	17	14	11	8	0	7	2	4	4	12;
12	9	9	13	13	24	25	18	15	7	0	6	5	4	7;
6	12	13	8	8	18	16	12	10	2	6	0	3	3	11;
7	8	10	13	12	23	21	23	14	5	7	5	0	3	12;
8	9	12	10	10	20	22	14	11	3	5	3	1	0	10;
14	4	4	18	18	31	29	32	20	12	8	11	10	9	0
]
demand = [0 380 360 497 400 500 585 500 200 345 350 900 120 s134 987]
timeWindow = [0 24; 9 16; 9 16; 9 16; 9 16; 10 16; 13 16; 9 16; 9 16; 9 16; 9 16; 10 16; 13 16; 9 16; 9 16; ]
travelTime = [0	22	28	22	22	26	22	27	24	11	26	18	15	20	29;
20	0	9	33	33	39	34	37	35	21	20	23	14	19	13;
27	8	0	40	40	42	38	40	42	25	17	21	19	18	10;
24	35	41	0	1	28	25	19	13	17	32	22	27	26	39;
24	36	41	1	0	28	25	19	13	18	32	23	27	26	40;
26	42	47	26	26	0	7	20	22	32	47	37	42	40	52;
22	37	43	23	23	6	0	17	19	29	44	34	37	37	47;
24	37	42	17	17	21	17	0	7	25	40	30	35	34	46;
25	38	44	12	13	22	19	6	0	20	35	25	30	29	43;
11	23	26	18	18	32	28	25	19	0	17	8	12	11	25;
25	19	16	34	34	48	44	41	35	16	0	12	10	9	15;
17	23	21	24	24	39	35	32	26	8	12	0	8	7	19;
15	15	21	28	27	38	34	36	29	12	15	12	0	9	23;
18	19	22	28	28	42	37	36	30	10	13	11	4	0	21;
30	13	9	42	42	48	44	46	44	25	17	21	19	18	0]
capacity = [1500 1500 1500 1500 1500]
save(fullfile(tempdir, 'customers.mat'),'noOfCustomers','noOfVehicles','distance','demand','timeWindow','travelTime','capacity')