package com.haxepunk.ai.behaviors;

/**
 * A selector chooses the first behavior that doesn't fail
 */
class Selector extends Composite
{

	override private function initialize()
	{
		_current = children.iterator();
		_currentBehavior = _current.next();
	}

	override private function update(context:Dynamic):BehaviorStatus
	{
		while (_currentBehavior != null)
		{
			var status = _currentBehavior.tick(context);

			if (status != Failure)
			{
				return status;
			}

			if (_current.hasNext())
			{
				_currentBehavior = _current.next();
			}
			else
			{
				break;
			}
		}
		return Failure;
	}

	private var _current:Iterator<Behavior>;
	private var _currentBehavior:Behavior;

}
