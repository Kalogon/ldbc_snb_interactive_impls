CREATE EXTENSION cameleon_graph;
LOAD 'cameleon_graph';
SET SEARCH_PATH=cameleon_graph, "$user", public;


---------------
-- create graph
SELECT create_graph('test');
---------------


---------------
-- create vertex
SELECT create_vertex('test', 'tagclassv', 'SELECT * FROM tagclass');
SELECT create_vertex('test', 'tagv', 'SELECT * FROM tag');
SELECT create_vertex('test', 'personv', 'SELECT * FROM person');
SELECT create_vertex('test', 'forumv', 'SELECT * FROM forum');

-- messagev = postv union commentv
-- SELECT create_vertex('test', 'messagev', 'SELECT * FROM message');
SELECT create_vertex('test', 'commentv', 'SELECT * FROM message WHERE parentmessageid is not null');
SELECT create_vertex('test', 'postv', 'SELECT * FROM message WHERE parentmessageid is null');
SELECT add_vertex_label('test', 5, 'messagev');
SELECT add_vertex_label('test', 6, 'messagev');

-- placev = cityv union countryv union continentv
-- SELECT create_vertex('test', 'placev', 'SELECT id, name, url FROM place');
SELECT create_vertex('test', 'cityv', 'SELECT * FROM city');
SELECT create_vertex('test', 'countryv', 'SELECT * FROM country');
SELECT create_vertex('test', 'continentv', $$SELECT id, name, url FROM place where type = 'Continent'$$);
SELECT add_vertex_label('test', 7, 'placev');
SELECT add_vertex_label('test', 8, 'placev');
SELECT add_vertex_label('test', 9, 'placev');

-- organisationv = universityv union companyv
-- SELECT create_vertex('test', 'organisationv', 'SELECT id, name, url FROM organisation');
SELECT create_vertex('test', 'universityv', 'SELECT * FROM university');
SELECT create_vertex('test', 'companyv', 'SELECT * FROM company');
SELECT add_vertex_label('test', 10, 'organisationv');
SELECT add_vertex_label('test', 11, 'organisationv');
---------------


---------------
-- create edge
SELECT create_edge('test', '(tagclassv)-[issubclassof]->(tagclassv)', '', 'select * from tagclassv t1, tagclassv t2, issubclassof where t1.subclassoftagclassid = t2.id');
SELECT create_edge('test', '(tagv)-[hastype]->(tagclassv)', '', 'select * from tagv, tagclassv, hastype where tagv.typetagclassid = tagclassv.id');

SELECT create_edge('test', '(personv)-[knows]->(personv)', 'select * from person_knows_person', 
            'select * from personv p1, personv p2, knows where p1.id = knows.person1id AND p2.id = knows.person2id');

SELECT create_edge('test', '(personv)-[hasinterest]->(tagv)', 'select * from person_hasinterest_tag', 
            'select * from personv, tagv, hasinterest where personv.id = hasinterest.personid AND tagv.id = hasinterest.tagid');
SELECT create_edge('test', '(forumv)-[hastag]->(tagv)', 'select * from forum_hastag_tag', 
            'select * from forumv, tagv, hastag where forumv.id = hastag.forumid AND tagv.id = hastag.tagid');
SELECT create_edge('test', '(messagev)-[hastag]->(tagv)', 'select * from message_hastag_tag', 
            'select * from messagev, tagv, hastag where messagev.id = hastag.id AND tagv.id = hastag.tagid');

SELECT create_edge('test', '(personv)-[islocatedin]->(cityv)', '', 'select * from personv, cityv, islocatedin where personv.locationcityid = cityv.id');
SELECT create_edge('test', '(universityv)-[islocatedin]->(cityv)', '', 'select * from universityv, cityv, islocatedin where universityv.locationplaceid = cityv.id');
SELECT create_edge('test', '(companyv)-[islocatedin]->(countryv)', '', 'select * from companyv, countryv, islocatedin where companyv.locationplaceid = countryv.id');
SELECT create_edge('test', '(messagev)-[islocatedin]->(countryv)', '', 'select * from messagev, countryv, islocatedin where messagev.locationcountryid = countryv.id');

SELECT create_edge('test', '(cityv)-[ispartof]->(countryv)', '', 'select * from cityv, countryv, ispartof where cityv.partofcountryid = countryv.id');
SELECT create_edge('test', '(countryv)-[ispartof]->(continentv)', '', 'select * from countryv, continentv, ispartof where countryv.partofcontinentid = continentv.id');

SELECT create_edge('test', '(personv)-[studyat]->(universityv)', 'select * from person_studyat_university', 
            'select * from personv, universityv, studyat where personv.id = studyat.personid AND universityv.id = studyat.universityid');
SELECT create_edge('test', '(personv)-[workat]->(companyv)', 'select * from person_workat_company', 
            'select * from personv, companyv, workat where personv.id = workat.personid AND companyv.id = workat.companyid');

SELECT create_edge('test', '(personv)-[likes]->(messagev)', 'select * from person_likes_message', 
            'select * from personv, messagev, likes where personv.id = likes.personid AND messagev.id = likes.id');
SELECT create_edge('test', '(messagev)-[hascreator]->(personv)', '', 
            'select * from messagev, personv, hascreator where messagev.creatorpersonid = personv.id');

SELECT create_edge('test', '(forumv)-[hasmoderator]->(personv)', '', 
            'select * from forumv, personv, hasmoderator where forumv.moderatorpersonid = personv.id');
SELECT create_edge('test', '(forumv)-[hasmember]->(personv)', 'select * from forum_hasmember_person', 
            'select * from forumv, personv, hasmember where forumv.id = hasmember.forumid AND personv.id = hasmember.personid');
SELECT create_edge('test', '(forumv)-[containerof]->(postv)', '', 
            'select * from forumv, postv, containerof where forumv.id = postv.containerforumid');

SELECT create_edge('test', '(commentv)-[replyof]->(messagev)', '', 
            'select * from commentv, messagev, replyof where commentv.parentmessageid = messagev.id');