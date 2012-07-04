select
ben.ben_id as beneficiaryId , ben.ben_code as beneficiaryCode,
ben.ben_first_name as beneficiaryName ,ben.ben_dob as beneficiaryDob,
'' as receivingOrganization ,
 CASE cg_gender
            WHEN 0 THEN 'Female'
            WHEN 1 THEN 'Male'
            WHEN -1 THEN 'Not Specified' END AS beneficiarySex,
ben.cg_id as careGiverId,
care.cg_code as careGiverCode,
care.cg_first_name as careGiverName
from tbl_beneficiary ben
join tbl_caregiver care on  ben.cg_id=care.cg_id
where ben.cg_id in (
'f9b3f48d-b1e4-461b-a6b8-86c3d5197a7f',
'42c041b8-fa24-405b-979e-048bb0aaad1c',
'e9d5d1c0-2032-42dc-b1f7-a95bf3fd9f76',
'9b80c7d6-58a9-454c-94ab-4967a6499857',
'9f069f89-1001-444e-a456-47c0cee9fde8',
'd7f83185-67dc-41cd-8436-0a98ae1251a6',
'cf8b42bb-3197-4ac7-b187-6ece8ffb4a6e',
'28d4199a-8afb-4af2-be02-5254bd89d3c6',
'0c53a8a4-d299-4753-a74b-1fbe751f19e5',
'c71111ad-45ac-4fab-a1a0-5502091f631d',
'8d9e2482-b343-4ccc-840a-e05125984164',
'8f1b2702-49ff-4fdb-96ce-ebe13b2d90c3',
'bb8ce7cf-c05e-40a7-a427-9dea3c89798e',
'909a109d-62ee-4a96-86e5-10e1bf0f3d26',
'fee28cc3-eb5a-4a87-a914-90e01bf5fe67',
'd60ddd88-02c1-47e6-8276-d98988ca435d',
'81000bf9-95cf-4508-ab99-504f8735ae40',
'4e0d1cf2-1317-4c1b-8a1e-76b39e62d642',
'7f369031-3dcb-4cef-849f-764fab30437d',
'c2de55cf-35c5-4b90-8bfd-c692eb4cd911',
'ee713bef-2d01-432e-900c-ffc200ce2f0d',
'fca18d1e-147c-480d-9a79-ff98b04f2f4d',
'94ce3ce4-78f2-46a9-9120-e6c3abb6ee96',
'0166dfd4-02a9-4f9e-921a-25c97318ff73',
'112b61b7-0dea-450a-8514-4afe617b3465',
'c2735541-3f9b-4034-81b7-1b1aedb2ae12',
'a7426e81-40b5-4edb-b295-37450f265761',
'a2044ee3-309f-4f40-b051-e731ef01870c',
'34894ff6-7fdb-4182-b76e-941b2ef60a7c',
'd774e6d6-6653-439b-bd8a-9e08f9cdca4a',
'a71bb695-b784-4081-8e22-8a95b9e80924',
'7caf53e6-f964-40ce-b8a6-a34d1892d282',
'fff494c3-3911-45f9-be66-e5f5c9f5d17f',
'276bb22a-fd58-4140-a451-355ad7c9844c',
'e564bef1-f93a-4422-8e98-13ab5b1e58a3',
'30be5c11-f9b1-4e51-b60c-e8a18dbcf439',
'c6503b87-9714-4a45-97c3-c175a6dfb724',
'ad74c67f-560c-48e1-92d8-215240a24803',
'734f27e4-338a-416f-8ce3-2439a97b24d0',
'b4eedd35-abfb-4d73-85f5-a96afaae140c',
'9e0de153-c4a6-4b53-aba7-24a140a5e2e9',
'f1651154-f6ce-4959-8b67-1211b38c30b8',
'48a5fffa-6183-4765-aaf2-ad7f44955acb',
'744ca91a-1cfc-49fd-a305-78be091a490e',
'2753035c-e31c-4a72-a8b8-3aa0ab49ccec',
'cbf71c3f-9fc9-401b-8d59-51a6d67bf64e',
'cb493eea-a4dd-4c6c-85cc-85fa03d57d78',
'b2cef07c-67a5-4267-b8b9-cf6016444320',
'eb968097-31dc-4798-b465-2e4e337dba82',
'3571d363-de80-4fc5-93f6-c53febbc310e',
'8ad89a68-a288-47b4-8da0-16535e0cc320',
'615778b0-b48b-42c4-ad92-7391e26b45a8',
'afeb1533-321a-48ac-975e-f4829424a363',
'3fb44262-2b4a-4fef-bd22-52fbbb9c6c75',
'c62d750b-0e83-44cf-ab5f-1fb5b0cc3f0b',
'175c3588-ed45-4df8-8622-2a68b513251e',
'83435098-149e-4ce3-a02f-2ba3cbb82153',
'39c35010-7f1e-4cb0-812d-66b8f6750ec9',
'3e631640-4087-4ad1-bc63-c53468daf5ed',
'a935a0ca-8116-4229-8003-1d466308a7fa',
'59619b90-60f7-4d6c-976d-4e04044520b5',
'96ca4443-9b18-44db-869b-ba86bfa54af2',
'56b77bb3-313b-4d03-bc70-a027a34af6e3',
'932aca82-44d9-4a43-8279-9cd7801e3d91',
'ba15ea46-1913-447e-8434-be38f4f2f1ad',
'c94257da-e84f-463d-b1be-d37973d341fb',
'b40c3a72-d1be-4fce-b89b-d484164be06a',
'6eec14a3-f128-478d-9a10-774e53d80554',
'6c580bb9-399a-4d53-9a9f-fc4e11e46507',
'6d7d360e-d9ee-4aa8-b6fa-8296353abf1a',
'01239466-bc96-4761-9e53-d725d1b146ac',
'3ca443b7-3a13-4031-a0e1-96556524ee0e',
'cb27ab47-d685-4160-8a03-02038a2986fa',
'f923082f-d019-4bd0-b613-93e04c9c875b',
'10af19b0-8fe7-4883-a4a8-cac03efc39a3',
'd9a939e9-0755-4c6d-9308-e36a12d3fd77',
'8015384e-3e02-4c26-a00d-76c61f58c572',
'68d148d6-7faa-468e-82c3-16321e3d1cd4',
'09cfbca3-08ef-45ad-9fec-733d17084138',
'99a159b0-209e-4574-81e8-8281ee38ab0e',
'd3288c01-b346-4b8e-8667-5b863e31af35',
'e7c9e7ab-1c8d-407b-9697-61712fd0d32a',
'60e07640-5871-435d-a7ca-6c17542a30e8',
'dfed13d1-91c9-4c3c-befa-caf582afc2f9',
'f89420b5-6f0a-4b30-8c27-f9e8fe5892ff',
'b366a575-2af7-4b84-b00b-79058a9959d6',
'9a91d99b-7843-4ab6-a2a3-362906d4e7e1',
'1b020c21-6616-44d8-87de-ee8f8dcb8334',
'd930e9f9-6892-40bf-bdee-cbf1342b5aff',
'e0a0b3b3-579b-45ba-8530-18a0d9196620',
'51b60716-d7fd-4ac2-a37b-07fa0f7b9454',
'2135fcad-fc8d-4130-a5f9-fb5d5f7c40e4',
'bfa6a5ad-853b-40f8-96da-2188cd2dbe7c',
'c9cbe673-4c5f-4ca4-b413-e69d319b7d58',
'eeb21044-cc4b-473f-b245-afd983c735bd',
'63d94aca-184e-4e1c-afe0-531721a7070b',
'09d2fed6-3812-49a9-997c-c893345a562a',
'44fa2bae-1cc0-480c-a25f-18d7e7ec17b0',
'0f9ae2fb-31f2-4fc4-b58a-c62fd9cb3c6a',
'8219d14e-e536-40e5-9786-7356a8d133c3',
'12d4a174-f999-408e-91b5-79153594b2eb',
'786b2a3e-e9db-4c80-8298-a49d2c33a795',
'2b683c2d-c6ea-4704-b426-0e3a6ea67603',
'dc5f6028-e6c6-420b-81f8-03a72fc3d13a',
'74c21a55-bc6c-4cb6-a66d-5d9c49859f35',
'509928b5-46a6-4c06-baa0-ab9a7b90a889',
'a1abb170-85e0-43ff-89e7-101628cbe27b',
'ade9553a-b536-44d7-8f3a-5eb0b6802ba4',
'bd6500f9-667a-4398-b25f-05dc5d968519',
'15b31bd3-eeb9-4854-96d1-2690dddc4f4b',
'd654b4a8-71f4-4bed-a51e-08ed174629a6',
'067498a2-11b0-4f2b-9137-c55ec868eb51',
'3a167ec7-257e-4721-810b-6cc71e64234a',
'c9567aa9-2461-4684-8384-ca85e4b8ace1',
'8767e5dc-e1e5-417c-b72c-ebc74b95ec68',
'65f93499-b9b0-40bb-b49d-1f125d5935d6',
'a2a5547c-683f-4fdd-9b47-b73f1fe3fb1a',
'6e473370-9a43-4fa5-bc48-6831bfe88868',
'6ee3c459-3788-4929-b3f6-1d430b4f61d7',
'5433346c-54d4-4ea7-83cc-84b5f38384bc',
'20116ae7-021b-4c7c-ab2e-70e5c9ac269e',
'19988717-4ba4-49a2-8940-542458061c53',
'b956232a-02bd-4136-a5be-c06842a9762d',
'ef0b14aa-11fe-4cb6-bbf8-a27ee280a3de',
'8843c3e3-0e09-4227-9c77-10c2db9996cd',
'9311e9a5-7bdb-4487-b5c7-b09965c24da5',
'9031f4c6-f764-4e7a-bd6b-a81ffe79023a',
'f3e0d3db-8622-499c-bc1f-708cbb5348e9',
'6bdf2542-975e-4a36-aa34-7988fc2f6dc5',
'6b2e705e-31a2-4fe4-968a-bbb7765eba98',
'7e0fc8a3-892c-4465-a1e3-276f2dfa77bf',
'35689c41-a46b-4628-b31b-93508f8750b7',
'83615e9e-7904-4d19-b00a-d5150ff52dd4',
'92f1e954-2d70-4834-a9a8-859ea89cca5b',
'b25fc6b0-4305-48ba-9879-665a2dc2ac7e',
'62bfbf24-f13d-475f-99c5-0ce9842f55af',
'b84e1ebd-2206-40f5-b5e6-6fadf41c830b',
'5f0eb01c-e037-4f2a-843e-7ef6b6ea503f',
'400fb449-1363-4dbc-bc52-93a4c3e815ff',
'760c9722-5872-42e6-8505-d81f55b2b3fd',
'bd704835-cc67-46a2-9db7-95fbaa88f9f7',
'da0ee55b-251c-4093-aa3a-f67436855daa',
'091336a6-ad60-4120-98a7-55085d2f89da',
'3a4c3a20-37fa-46bc-b902-ab719a8d905f',
'6175fcca-87da-43fb-a0e0-790d193ce1fc',
'e6feb05c-f0a9-4495-b391-b2b7d2ca72fc',
'6579edf9-a86a-4a95-b946-4ffe7efd79ca',
'4d88f388-4efd-422b-ab6d-1a4e52ba693a',
'a550f846-c49b-4fe1-bcc3-d9c58222d10d',
'c2d8bcd6-4d1d-481c-bfe9-e19feee87b51',
'ba4ae4ef-1b7f-4b0a-a89d-f538dc2f67d4',
'd2ae65c8-69f8-4546-b657-e1cb39fe56fa',
'7b85daf2-2b6f-4f7c-a4e8-ee2e2e83a4d8',
'bd147830-d068-4fef-a7e3-9ed3fee46b4e',
'e4d41bc7-7052-4c12-8095-28e1f067634f',
'6a1d8bc0-df96-4e1c-8844-be5898d24e42',
'46ccd571-5ca3-45de-8080-3f8c5069d7a3',
'cb8bb6e3-dbdd-4c5d-bf71-23d21e09d5ee',
'295ebf28-c38b-4b8b-9d85-8d394ccf344a',
'35107faa-284a-4a78-8053-2f4034e00444',
'c5df12af-347e-4be7-81a9-5cb33be4456c',
'a83ef4a8-e60d-45f2-9784-c914411f219b',
'3cdc5c17-81a7-48f7-a130-e9e19a056717',
'0cc13103-3302-4cce-ab1c-e257fbe6b369',
'1335c016-24cb-4757-95e6-a37aedd1daef',
'f2929f5a-0de6-4377-94b1-186c558e6f2e',
'dd37dd89-9690-4f96-9cba-b24a371abaca',
'7e8e0054-2d12-4159-bf1b-3f6bb758047e',
'ea5661a7-58c5-4d02-aedf-3b7edc98b4c7',
'8179816e-dd5d-424b-a6be-b8fe66f2a273',
'baa248c8-dd29-42b7-8230-c683717b7bbb',
'2dca644a-e059-4c14-85b9-55f3cee050c4',
'27ca44a2-cbab-4709-b0eb-1a9e49c92083',
'60cc55af-dfbc-4a4e-b771-707ebc9f566b',
'a5d1fea2-57f2-4ea7-abfe-e28890c800db',
'ed3a664b-3105-488e-8a5e-d59c966157fb',
'ed4cc478-68f0-4ab6-872d-1989c283b8ec',
'69260ebf-2cb1-426a-b50c-b4e50810ab0c',
'6521eaaa-b189-4420-a5af-01893b2f5a37',
'd73cac4b-f758-4592-adfd-b48bed1a9d1d',
'76153085-c1ce-413a-b21a-8e8db6fabfa8',
'09955d7c-6b8e-49ef-9b2f-f63558228855',
'd199412e-8771-4252-b772-5a6b80783ae6',
'872e6a07-80a6-4e62-840a-e3decfdbf909',
'1207c075-32a6-4ef3-92c6-2ff25a6a35a5',
'c4d57e8d-4ea6-4ae4-937e-d9c00bb0c547',
'fe291f28-95d4-4a5c-94d5-6d7eb64899f5',
'9865c9bd-56a7-4333-a19c-2e468a0cc110',
'1ff3d611-6658-4ebf-bcc2-11a764b3a1c8',
'2b54ef37-dba4-4e3d-83aa-54a8731fcea0',
'3de3de4d-2749-4b95-9837-825eeb046411',
'429ad4aa-2cca-46dd-b2ec-7efb10857468',
'41ebe8ae-e99c-4e3a-ad6c-f39016fb1c9a',
'566097f8-f766-4ddb-92d8-093a48a141ba',
'7babdaff-bdea-4c43-a869-ed2aa8c18f42',
'397671f5-8396-4bfb-8b75-afc18452dfde',
'26373e02-36a7-4fd0-bdb6-d31da8d0d6d7',
'e918cf06-dd01-4c52-8e7e-8883b259c7fe',
'354aef51-026d-4001-8496-19c93724ca33',
'76570029-fe44-48f8-9433-1014f453df9e',
'4598e5a0-1a2f-4872-b46c-10fc3bbce1f4',
'd38a720f-a638-4489-987a-d877c61409ce',
'3d6e523f-9fd4-442f-8a47-65159df7455c',
'f0df18ef-b134-40e0-9e4d-9e149dd4e7f8',
'18e57d16-f872-42e8-a2e7-defda0eaecec',
'320303a6-78f2-4bb2-98bc-ca459a7af055',
'0cb69576-85ba-4867-8ac4-ac9a82b4e6ed',
'617a8605-40cf-4085-80f3-f5646796daf8',
'e037130b-57ae-40f3-9edb-2c9dad1a23cc',
'37fd7f99-3fd0-40cc-9754-03ba3f2321eb',
'a9620222-aeec-4280-a1fa-fdff1485407a',
'722f60b9-a4bd-409c-8223-8675ad1913ab',
'a3290541-6a04-4c54-aa85-589d214269ab',
'ac7b7008-1adf-497a-846d-2b5a7196915d',
'b9f4565f-62b9-4630-8133-cdd3a1b463b8',
'1210e87a-64a9-4651-b6e2-a37df500094f',
'a941bcb8-b3e9-46f0-a108-82db9377702d',
'99025f0f-789d-4f6b-9851-183d5f8bbc93',
'0e47f7ef-b6c1-4c75-b497-9e5dc6d3859d',
'79b5c9a3-843c-4082-b8cc-5e055da22877',
'81b33d5d-6bd2-4393-81e2-20b825d49a45',
'9c9900ce-d389-4656-8978-8870cb028d71',
'231b54d4-cd92-4504-9bd3-f95b17d8c6c2',
'6253bb06-82a8-48c8-b8cb-c99b111ed429',
'3ab054ee-d2eb-4daa-854c-091b6a491ae0',
'60a52121-f9fe-4049-8d00-e22ec960f0f4',
'def5dd66-ccf7-483e-8246-1249d05df4f1',
'c914ec21-eb90-4a3f-a171-2f243dae65da',
'5c3cb2bf-6274-4afd-afc5-599ce9c77664',
'e59320d7-4ab6-46f8-b421-dd15599e7b85',
'3e86d9ba-8ea6-4144-8359-7995c2b7ecec',
'3fcd3429-1afe-45c0-bf4f-e26992825640',
'5f965412-9eaa-4b92-91c9-58f532f17db0',
'7d89a994-c9a8-4e74-b17d-320e4222d189',
'e5c32d7d-58ac-40cc-ad8c-cdc8f981ac4d',
'3bf7d83d-e9ae-4e2d-88c8-ca29ce00c3bf',
'5cc0a157-94ea-4458-9ad4-4405a8333ee3',
'710a0810-b61f-468d-b714-b2f8f6b738c8',
'463f6b2a-2057-4e99-8592-71e05967a59c',
'afdea5b5-9c2a-4838-918e-b77c98144e29',
'ca9cf5c6-cf95-448f-b67a-7c4912f4a925',
'9c085436-e108-4988-94cd-bf3e79a2c62a',
'8c4e7c75-39a1-46f2-9004-bb9ddc5cec63',
'a435a1f5-2322-4cf3-bf55-2bf3951f7a0f',
'16f30500-cc40-4fbf-bf39-2a728b44ab2c',
'f054eefd-67c4-4f4c-91ac-53459584b3a1',
'3622f067-3a31-470e-98d8-c3e17f7448c1',
'8b744b76-ed3d-451d-ae7e-4bc19d3fb262',
'58fa668b-f342-4f5e-af1d-053143b78394',
'81b6a0be-7299-443c-bc0b-eeb5fe4738e6',
'4040e636-5ee7-4a3c-9b8c-ef5009bdb76c',
'365fa567-9f1c-4108-bd25-c1d47dea24db',
'a183ae2f-85a5-493d-8252-e874874d681a',
'1657777d-9191-4b94-9c1a-6048ab1898d3',
'ec6677ac-be66-42a1-822a-d8325413cb3e',
'74467cd8-3bd8-4fea-b243-84f94671f086',
'0c18898f-6c72-4b94-ac50-d5b848692bd9',
'5b6caf10-99ee-44f7-9e3d-ceeb03ab8649',
'f77819f6-cc6a-4afc-80c1-a45dc8c585f8',
'83f29db3-8425-4c6c-b8a7-993d848365d4',
'b83e7147-9edd-43b8-aa59-e7c3f87c7139',
'4620f124-6beb-430f-9098-62f65d4b5c77',
'c6582df9-6eb9-4be1-ae0c-f0da14ae3baf',
'81821539-0eab-4a95-bacc-915c87b0d10d',
'2b0bcf67-abed-44d3-b5c1-9eb7343b1163',
'7d78cf99-5ee6-447b-8cd6-daf1a2622570',
'c7dbab11-b2ed-4023-b3c0-92bfc95af249',
'f6dbf448-8d54-4427-918c-77098a70839d',
'ab28389b-d77b-44a7-8afe-79bf15988baa',
'934db7c7-c89d-4b82-8d8e-8bb7315aa397',
'bbea8173-1b6c-46ba-b45b-ab65f3fa2405',
'a5759f69-ca13-4114-b5f2-49c21f88626b',
'4466401b-72bd-4321-b931-768b34d1bb22',
'f5c514a2-33d1-47c6-abaf-48ccf6178cc2',
'fb8c192a-3ae5-4ea3-8e8a-757a3723ec67',
'0e0e9320-322a-4020-9d3c-db7c6ff5c737',
'8105172a-941a-4ebd-bb73-14f2003bb3d6',
'5fa5c068-f34a-4ccb-ac5d-56a531c9e76d',
'bbb2ca3a-ad2e-4310-a114-a7e20ef27e81',
'5389d422-ce22-4229-b43c-c17c1c7aa603',
'75f63d01-3918-4e19-b034-755f98b14c30',
'49638bcf-eb14-4cc7-9773-3bc05fa2175f',
'75e0ff4d-eb98-4930-973f-6da311e3c562',
'55fd13bb-9d13-47a6-a44b-bd255b0db194',
'e194c0df-662c-4c01-baa4-6853caae47cb',
'f4223217-239d-450e-a69c-17ff58ad81f7',
'd01c4d7d-9aab-4989-b0c8-8fc0ccc6fdc9',
'10eb85a3-f4dd-436f-87bb-aa789862364f',
'e4bef384-ffa3-41a6-a2a9-52f8c39821ba',
'88d582f9-b936-4c96-9bc3-72426db6db3d',
'1fda2e9d-3386-41b0-b7f3-43eb5006b917',
'319f6230-4a4b-42be-a00c-f217abdec2c9',
'7151223c-2f7e-4afe-8e77-93c72d92a544',
'8400a167-6ee7-46bf-a716-bd7df27a8439',
'09e11af7-5d22-44fc-a74d-2a2e89aca7e3',
'ec9ff517-8752-4495-be18-94e69b0e2f19',
'963e1ece-d094-4e90-9dc8-8059b748903b',
'49ce6b78-ad04-4c93-867b-2d69ceb21400',
'a38f7168-2abb-4324-ad0e-429e5012080c',
'bcf08998-0fe8-494b-9d5a-b07cba32dc17',
'438867fa-5cd9-45b8-9050-ad98c29816ee',
'5cf77ab5-a1bb-4782-847e-7daaad1c41fd',
'5edf0a03-fe92-413e-a8eb-63e9a60d7c50',
'aa4bb6bf-58c0-42e9-92a1-dedf6fe48434')