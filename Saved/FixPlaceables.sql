/*
 *	This scripts fixes placeables:
 *  - It fixes Fish Traps, Shellfish Traps, Beehives and Water Wells not working after restart
 *  - It fixes Wheels of Pain stopping on restart 
 *  - It fixes Naming of T3 altars that have been upgraded
 *
 */

INSERT INTO properties (object_id, name, value)
  SELECT DISTINCT id, classname || '.HasBeenPlacedInWorld' as name, X'0000000001' as value
  FROM
  (
    SELECT replace(class, rtrim(class, replace(class, '.', '')), '') AS classname, id
    FROM actor_position
    WHERE classname IN ('BP_PL_Crafting_FishNet_C', 'BP_PL_Crafting_CrabPot_C', 'BP_PL_Crafting_Beehive_C', 'BP_PL_Crafting_Beehive_Improved_C',
      'BP_PL_Water_Well_C', 'BP_PL_Water_Well_Large_C', 'BP_PL_Water_Well_Tier2_C', 'BP_PL_Water_Well_MitraStatue_C',
      'BP_PL_Crafting_Water_Well_C', 'BP_PL_Crafting_Water_Well_Large_C', 'BP_PL_Crafting_Water_Well_Tier2_C', 'BP_PL_Crafting_Water_Well_MitraStatue_C',
      'BP_PL_CraftingStation_WheelOfPain_C', 'BP_PL_CraftingStation_WheelOfPainXL_C', 'BP_PL_CraftingStation_WheelOfPainXXL_C')
  )
  WHERE id NOT IN
  (
    SELECT object_id
    FROM properties
    WHERE replace(name, rtrim(name, replace(name, '.', '')), '') LIKE 'HasBeenPlacedInWorld'
  );

INSERT INTO properties (object_id, name, value)
  SELECT DISTINCT object_id AS object_id, 'CraftingQueue.m_IsRunning' AS name, X'0000000001' AS value
  FROM
  (
  SELECT object_id
  FROM properties
  WHERE name = 'CraftingQueue.m_IsStarted' AND value = X'0000000001'
    AND object_id NOT IN
    (
      SELECT DISTINCT object_id FROM properties WHERE name LIKE 'CraftingQueue.m_IsRunning'
    )
    AND object_id IN
    (
      SELECT DISTINCT id
  	  FROM actor_position
      WHERE replace(class, rtrim(class, replace(class, '.', '')), '') IN ('BP_PL_CraftingStation_WheelOfPain_C', 'BP_PL_CraftingStation_WheelOfPainXL_C', 'BP_PL_CraftingStation_WheelOfPainXXL_C')
    )
  );


INSERT INTO properties (object_id, name, value)
  SELECT DISTINCT object_id AS object_id, 'BP_PL_Altar_Mitra_T3_C.SourceItemTemplateID' AS name, X'000000004d3c0100' AS value
    FROM (
      SELECT object_id FROM properties WHERE name='BP_PL_Altar_Mitra_T3_C.DecayTimestamp'
      AND object_id NOT IN (
        SELECT object_id FROM properties WHERE name='BP_PL_Altar_Mitra_T3_C.SourceItemTemplateID'
      )
    );

INSERT INTO properties (object_id, name, value)
  SELECT DISTINCT object_id AS object_id, 'BP_PL_Altar_Derketo_T3_C.SourceItemTemplateID' AS name, X'00000000333c0100' AS value
    FROM (
      SELECT object_id FROM properties WHERE name='BP_PL_Altar_Derketo_T3_C.DecayTimestamp'
      AND object_id NOT IN (
        SELECT object_id FROM properties WHERE name='BP_PL_Altar_Derketo_T3_C.SourceItemTemplateID'
      )
    );

INSERT INTO properties (object_id, name, value)
  SELECT DISTINCT object_id AS object_id, 'BP_PL_Altar_Set_T3_C.SourceItemTemplateID' AS name, X'00000000393c0100' AS value
    FROM (
      SELECT object_id FROM properties WHERE name='BP_PL_Altar_Set_T3_C.DecayTimestamp'
      AND object_id NOT IN (
        SELECT object_id FROM properties WHERE name='BP_PL_Altar_Set_T3_C.SourceItemTemplateID'
      )
    );

INSERT INTO properties (object_id, name, value)
  SELECT DISTINCT object_id AS object_id, 'BP_PL_Altar_Yog_T3_C.SourceItemTemplateID' AS name, X'00000000433c0100' AS value
    FROM (
      SELECT object_id FROM properties WHERE name='BP_PL_Altar_Yog_T3_C.DecayTimestamp'
      AND object_id NOT IN (
        SELECT object_id FROM properties WHERE name='BP_PL_Altar_Yog_T3_C.SourceItemTemplateID'
      )
    );

INSERT INTO properties (object_id, name, value)
  SELECT DISTINCT object_id AS object_id, 'BP_PL_Altar_Ymir_T3_C.SourceItemTemplateID' AS name, X'00000000523c0100' AS value
    FROM (
      SELECT object_id FROM properties WHERE name='BP_PL_Altar_Ymir_T3_C.DecayTimestamp'
      AND object_id NOT IN (
        SELECT object_id FROM properties WHERE name='BP_PL_Altar_Ymir_T3_C.SourceItemTemplateID'
      )
    );
